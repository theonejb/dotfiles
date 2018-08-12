(setq exec-path-from-shell-check-startup-files nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("e3f648bb477a2e2332124f5ca8bd070e8624f152be6b4478668a69e5de7510ff" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "59171e7f5270c0f8c28721bb96ae56d35f38a0d86da35eab4001aebbd99271a8" "61003d455ba1bad9a3bf8be7342e848ca3febe899319e95a9dc3d804d9697608" default)))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(org-agenda-files
   (quote
    ("~/Dropbox/orgmode/agile-leaf.org" "~/Dropbox/orgmode/felix.org" "~/Dropbox/orgmode/thestoicmuslim.org" "~/Dropbox/orgmode/shoes.org" "~/Dropbox/orgmode/notes.org")))
 '(package-selected-packages
   (quote
    (request lua-mode expand-region counsel-projectile projectile cider paredit switch-window all-the-icons zerodark-theme exec-path-from-shell ledger-mode company zenburn-theme ivy)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(exec-path-from-shell-initialize)

(load-file "~/.emacs.d/locals.el")

(push "~/.emacs.d/scripts/" load-path)

(ivy-mode 1)
(counsel-mode 1)

(load-theme 'zerodark t)
(zerodark-setup-modeline-format)

;; Company mode settings
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'company-mode-hook (lambda () (local-set-key (kbd "M-c") 'company-complete)))

;; Auto mode alist for Ledger files
(add-to-list 'auto-mode-alist '("\\.journal\\'" . ledger-mode))
(add-hook 'ledger-mode-hook (lambda ()
			      (local-unset-key (kbd "M-c"))
			      ))

;; Switch Window
(require 'switch-window)
(global-set-key (kbd "s-<tab>") 'switch-window)

;; WindMove
(windmove-default-keybindings)

;; Avy
(global-set-key (kbd "C-c C-c f") 'avy-goto-char)

;; iy-move-to-char
(require 'iy-go-to-char)
(global-set-key (kbd "C-c f") 'iy-go-up-to-char)
(global-set-key (kbd "C-c F") 'iy-go-to-char-backward)

;; Easier paren editing
(show-paren-mode 1)

;; Expand selection to word/quote/etc easliy
(global-set-key (kbd "s-<up>") 'er/expand-region)

;; Projectile mode with Counsel/Ivy integration
(projectile-mode)
(counsel-projectile-mode)

;; Easy access to commonly accessed files
(global-set-key (kbd "C-c j") (lambda ()
				(interactive)
				(find-file "~/Dropbox/Ledgers/current.journal")
				))
(global-set-key (kbd "C-c i") (lambda ()
				(interactive)
				(find-file "~/.emacs.d/init.el")
				))
(global-set-key (kbd "C-c o") (lambda ()
				(interactive)
				(find-file "~/Dropbox/orgmode/notes.org")
				))

;; Clojure mode additions
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'superword-mode)

;; Org-mode
(add-hook 'org-mode-hook (lambda () (company-mode -1)))  ; Disable auto complete
(setq org-M-RET-may-split-line nil) ; Always create a new item below without spliting the current line
(setq org-directory "~/Dropbox/orgmode")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; Allow refiles to all .org extension files in the orgmode directory
(require 'seq)
(setq my-org-files (mapcar
		    (lambda (x) (cons (concat "~/Dropbox/orgmode/" x) '(:level . 1)))
		    (seq-filter (lambda (x) (string-suffix-p ".org" x t)) (directory-files "~/Dropbox/orgmode"))))
(setq org-refile-targets (append '((nil . (:level . 1))
				   (nil . (:level . 2)))
				 my-org-files))

;; Custom Capture templates
(setq org-capture-templates '(
			      ("t" "Todo" entry (file+headline "~/Dropbox/orgmode/notes.org" "Tasks") "* TODO %?\n  %t")
			      ("d" "Todo with deadline" entry (file+headline "~/Dropbox/orgmode/notes.org" "Tasks") "* TODO %?\n  DEADLINE: %t")
			      ))

(require 'request)
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
    (insert (number-to-string owed-amount))))

(add-hook 'ledger-mode-hook (lambda ()
			      (local-set-key (kbd "C-c u") 'update-journal-from-lkeep)
			      (local-set-key (kbd "C-c c") 'credit-card-remaining-limit)
			      ))

(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))
(global-set-key (kbd "C-c e") 'eval-and-replace)
