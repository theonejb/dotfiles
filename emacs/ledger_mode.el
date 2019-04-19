(require 'request)

;; Auto mode alist for Ledger files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))
(add-hook 'hledger-mode-hook (lambda ()
			      (local-unset-key (kbd "M-c"))
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

(add-hook 'hledger-mode-hook (lambda ()
			      (local-set-key (kbd "C-c s") 'account-shortcode->entry)
			      (local-set-key (kbd "C-c c") 'credit-card-remaining-limit)
			      (local-set-key (kbd "C-c b") 'remaining-unbudgeted-amount)
			      ))
