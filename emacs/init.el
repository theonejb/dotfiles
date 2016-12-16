(setq mac-command-modifier 'meta)
(setq mac-option-modifier nil)

(when window-system (set-frame-size (selected-frame) 125 45))

(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)

(when (memq window-system '(mac ns))
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(require 'neotree)
(setq neo-window-width 40)
(global-set-key (kbd "C-`") 'neotree-toggle)

(require 'all-the-icons)
(setq neo-theme 'icons)

(load-theme 'zerodark t)

(require 'linum-relative)
(linum-relative-on)
(global-linum-mode t)

; Jedi level stuff!
(require 'virtualenvwrapper)
(add-hook 'python-mode-hook (lambda ()
			      (defun workon-setup ()
				"Switch the virtual env and stop the Jedi server so it starts with the correct env"
				(interactive)
				(venv-workon)
				(jedi:stop-server))
			      (local-set-key (kbd "C-c v") 'workon-setup)))
(setq mode-line-format (cons '(:exec venv-current-name) mode-line-format))			   

(setq jedi:complete-on-dot t)
(setq jedi:environment-root "jedi-p2")
(add-hook 'python-mode-hook 'jedi:setup)

(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-c f") 'helm-find-files)
(helm-mode 1)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(sml/setup)

(global-set-key (kbd "C-c i") (lambda ()
				"Edit the ~/.emacs.d/init.el file"
				(interactive)
				(find-file "~/.emacs.d/init.el")))

(show-paren-mode 1)

; Reroute autosave and backup files to temp folder
(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
