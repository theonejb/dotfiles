;; Auto mode alist for Ledger files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . ledger-mode))
(add-hook 'ledger-mode-hook (lambda ()
			       (local-unset-key (kbd "M-c"))
			       ))

(setq ledger-binary-path "hledger")
(setq ledger-mode-should-check-version nil)

(defun amount-only-from-hledger-amount-string (amount)
  (replace-regexp-in-string "," "" (nth 1 (split-string amount))))

(defun print-cc-remaining-limit ()
  (interactive)
  (let* ((limit 24000)
	 (cc-bal-str (shell-command-to-string "hledger bal '^liabilities:credit card$' --format='%-(total)' | tail -1"))
	 (cc-bal (string-to-number (amount-only-from-hledger-amount-string cc-bal-str))))
    (message (format "Remaining CC balancer: %.2f" (- limit (* -1 cc-bal))))))
(defalias 'cc-limit 'print-cc-remaining-limit)

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
	 (cleaned-budgeted-amount-string (amount-only-from-hledger-amount-string budgeted-amount-string))
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

(setq expense-account-mappings '(
				("food" . "nbd:discretionary:food")
				("entertainment" . "nbd:discretionary:entertainment")
				("transport" . "nbd:transport")
				("utility" . "nbd:utility")
				))
(defun expense->entry (expense-category amount)
  (interactive (list
		(completing-read "Expense category code" (mapcar 'car expense-account-mappings))
		(read-string "Amount: ")))
  (let ((expense-account (cdr (assoc expense-category expense-account-mappings))))
    (if expense-account
	(progn
	  (insert (format "expenses:%s  %s" expense-category amount))
	  (newline-and-indent)
	  (insert (format "%s  -%s" expense-account amount)))
      (message "No expense account mapping found for %s" expense-category))))

(defun cc-expense->entry (expense-category amount)
  (interactive (list
		(completing-read "Expense category code" (mapcar 'car expense-account-mappings))
		(read-string "Amount: ")))
  (let ((expense-account (cdr (assoc expense-category expense-account-mappings))))
    (if expense-account
	(progn
	  (insert (format "expenses:%s  %s" expense-category amount))
	  (newline-and-indent)
	  (insert (format "liabilities:credit card  -%s" amount))
	  (newline-and-indent)
	  (insert (format "nbd:cc  %s" amount))
	  (newline-and-indent)
	  (insert (format "%s  -%s" expense-account amount)))
      (message "No expense account mapping found for %s" expense-category))))

(add-hook 'ledger-mode-hook (lambda ()
			      (local-set-key (kbd "C-c s") 'account-shortcode->entry)
			      (local-set-key (kbd "C-c r") 'expense->entry)
			      (local-set-key (kbd "C-c t") 'cc-expense->entry)
			      (local-set-key (kbd "C-c c") 'cc-limit)
			      (local-set-key (kbd "C-c b") 'remaining-unbudgeted-amount)
			      ))
