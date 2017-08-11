(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(when window-system (set-frame-size (selected-frame) 125 45))

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(when (memq window-system '(mac ns))
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(setq neo-window-width 40)
(global-set-key (kbd "C-`") 'neotree-toggle)

(setq neo-theme 'icons)

(set-face-attribute 'default nil :height 140)
(load-theme 'zerodark t)

(require 'linum-relative)
(linum-relative-on)
(global-linum-mode t)
(setq linum-format "%3d")

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-c f") 'helm-find-files)
(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

(add-hook 'web-mode-hook (lambda ()
                           (emmet-mode)))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (setq web-mode-enable-auto-quoting nil))))

(sml/setup)
(delight '(
           (helm-mode)
           (projectile-mode " P" projectile)
           (superword-mode nil subword)
           (paredit-mode " (" paredit)
           ))

(global-set-key (kbd "C-c i") (lambda ()
                                "Edit the ~/.emacs.d/init.el file"
                                (interactive)
                                (find-file "~/.emacs.d/init.el")))

(show-paren-mode 1)

; Reroute autosave and backup files to temp folder
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

(windmove-default-keybindings)
(global-set-key (kbd "S-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-M-<down>") 'shrink-window)
(global-set-key (kbd "S-M-<up>") 'enlarge-window)

(global-set-key (kbd "C-c s") (lambda ()
                                (interactive)
                                (split-window-vertically)
                                (other-window 1)
                                (eshell "new")))
(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

(global-set-key (kbd "C-=") 'er/expand-region)

(setq-default indent-tabs-mode nil)
(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'prog-mode-hook 'auto-complete-mode)
(add-hook 'prog-mode-hook 'superword-mode)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
(global-set-key (kbd "C-c C-d") 'duplicate-line)

(defun create-line-below()
  (interactive)
  (move-end-of-line 1)
  (open-line 1)
  (next-line 1))
(global-set-key (kbd "C-o") 'create-line-below)

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'lisp-mode 'rainbow-delimiters-mode)

(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'load-path
             (expand-file-name "/usr/local/Cellar/ledger/3.1.1_5/share/emacs/site-lisp/ledger/"))
(add-to-list 'auto-mode-alist '("\\.journal$" . ledger-mode))

(add-hook 'org-mode-hook (lambda ()
                           (interactive)
                           (linum-relative-off)))

(global-set-key (kbd "C-c n") (lambda ()
                                (interactive)
                                (find-file "/Users/asadjb/Dropbox/orgmode/notes.org")))

(global-set-key (kbd "C-c w") (lambda ()
                                (interactive)
                                (find-file "/Users/asadjb/Programming/Felix/notes.org")))

(setq inhibit-startup-screen t)
(find-file "~/Dropbox/orgmode/notes.org")
