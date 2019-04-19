(require 'request)

;; Auto mode alist for Ledger files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))
(add-hook 'ledger-mode-hook (lambda ()
			      (local-unset-key (kbd "M-c"))
			      ))

(defun journal-delete-data
    ()
  (if (y-or-n-p "Delete transactions in Ledger Keeper? ")
      (request
       "https://lkeep.agileleaf.com/expenses/api/delete-all/"
       :type "POST"
       :headers lkeep-auth-headers
       :success (cl-function
		 (lambda (&key data &allow-other-keys)
		   (message "Deleted")))
       :error (cl-function
	       (lambda (&key error-thrown &allow-other-keys)
		 (message "Error from Ledger Keeper API. Error: %S" error-thrown))))
    (message "Not deleting")))

(cl-defun journal-update-success-callback
    (&key data response &allow-other-keys)
  (if (string-match "/login/" (request-response-url response))
      (message "Unable to authenticate with Ledger Keeper")
    (progn (insert data)
	   (journal-delete-data)
	   (ledger-mode-clean-buffer)
	   (goto-char (point-max))
	   )))

(defun update-journal-from-lkeep ()
  (interactive)
  (message "Getting data from Ledger Keeper")
  (request
   "https://lkeep.agileleaf.com/expenses/api/export/journal/"
   :type "GET"
   :parser 'buffer-string
   :headers lkeep-auth-headers
   :success 'journal-update-success-callback
   :error (cl-function
	   (lambda (&key error-thrown &allow-other-keys)
	     (message "Error from Ledger Keeper API. Error: %S" error-thrown)))
   ))
(defun credit-card-remaining-limit ()
  (interactive)
  (let* ((limit 24000)
	 (remaining-credit-string (read-string "Remaining credit limit:"))
	 (cleaned-credit-string (replace-regexp-in-string "," "" remaining-credit-string))
	 (owed-amount (- (string-to-number cleaned-credit-string) limit)))
    (insert (format "%.2f" owed-amount))))
(defun remaining-unbudgeted-amount (remaining-balance-string)
  (interactive "sCurrent balance: ")
  (let* ((cleaned-balance-string (replace-regexp-in-string "," "" remaining-balance-string))
	 (balance-amount (string-to-number cleaned-balance-string))

	 (budgeted-amount-string (shell-command-to-string "hledger bal '^assets:cash:nbd' 'not:^assets:cash:nbd:unbudgeted$' --format='%-(total)' | tail -1"))
	 (cleaned-budgeted-amount-string (replace-regexp-in-string "," "" (nth 1 (split-string budgeted-amount-string))))
	 (budgeted-amount (string-to-number cleaned-budgeted-amount-string)))
    (insert (format "%.2f" (- balance-amount budgeted-amount)))))

(setq account-shortcodes '(
			   ("cc" "liabilities:credit card" "(tob:monthly:cc)")
			   ("saving" "nbad:saving" "(tob:monthly:nbad)")
			   ))

(defun account-shortcode->entry (shortcode amount)
  "Given a shortcode that has an entry in the account-shortcodes alist, and an amount, this function will add an account entry for each of the accounts associated with the shortcode"
  (interactive (list (completing-read "Account shortcode" (mapcar 'car account-shortcodes)) (read-string "Amount: ")))
  (let ((accounts (cdr (assoc shortcode account-shortcodes))))
    (if (not accounts)
	(message "Shortcode %s not found in accounts map" shortcode)
      (dolist (current-account accounts)
	(insert (format "%s  %s" current-account amount))
	(newline-and-indent))
      )))

(add-hook 'ledger-mode-hook (lambda ()
			      (local-set-key (kbd "C-c u") 'update-journal-from-lkeep)
			      (local-set-key (kbd "C-c s") 'account-shortcode->entry)
			      (local-set-key (kbd "C-c c") 'credit-card-remaining-limit)
			      (local-set-key (kbd "C-c b") 'remaining-unbudgeted-amount)
			      ))

(with-eval-after-load "ledger"
  (defun ledger-read-transaction ()
    "Read the text of a transaction, which is at least the current date."
    (let ((reference-date (current-time)))
      (read-string
       "Transaction: "
       ;; Pre-fill year and month, but not day: this assumes DD is the last format arg.
       (ledger-format-date reference-date)
       'ledger-minibuffer-history))))
