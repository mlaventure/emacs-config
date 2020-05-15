;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
; (package-initialize)

(require 'org)
(org-babel-load-file
 (expand-file-name "config.org"
                   user-emacs-directory))

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-buffer-list-filter (quote ignore))
 '(git-gutter:update-interval 2)
 '(magit-auto-revert-immediately nil)
 '(magit-auto-revert-mode nil)
 '(package-selected-packages
   (quote
    (csv-mode company-tern tern rjsx-mode web-mode typescript-mode stickyfunc-enhance centaur-tabs treemacs-magit treemacs-icons-dired treemacs-projectile json-mode helm-rg python-mode pipenv company-anaconda pyenv-mode anaconda-mode bitbake-modes spaceline racer flycheck-rust rust-mode vlf helm-projectile projectile markdown-mode yaml-mode protobuf-mode toml-mode dockerfile-mode git-gutter-fringe direnv go-playground godoctor go-guru company-go go-eldoc go-mode company flycheck helm-flx flx helm-fuzzier helm undo-tree column-enforce-mode fill-column-indicator spaceline-all-the-icons moe-theme fancy-battery highlight-thing smartparens which-key neotree buffer-move nlinum default-text-scale all-the-icons rainbow-delimiters diminish auto-compile use-package)))
 '(safe-local-variable-values
   (quote
    ((eval add-to-list
           (quote python-shell-extra-pythonpaths)
           . "/home/mlaventure/work/Verkada-Backend")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(bitbake-python-expansion-face ((t (:background "dark magenta"))))
 '(bitbake-python-function-face ((t (:background "dark violet"))))
 '(bitbake-python-task-face ((t (:background "dark magenta"))))
 '(bitbake-shell-function-face ((t (:background "dark cyan"))))
 '(column-enforce-face ((t (:inherit font-lock-warning-face :underline t :foreground "violet red"))))
 '(company-preview ((t (:foreground "darkgray" :underline t))))
 '(company-preview-common ((t (:inherit company-preview))))
 '(company-scrollbar-bg ((t (:background "lightgray"))))
 '(company-scrollbar-fg ((t (:background "darkgrey"))))
 '(company-tooltip ((t (:background "lightgray" :foreground "black"))))
 '(company-tooltip-common ((((type x)) (:inherit company-tooltip :weight bold)) (t (:inherit company-tooltip))))
 '(company-tooltip-common-selection ((((type x)) (:inherit company-tooltip-selection :weight bold)) (t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:background "steelblue" :foreground "white"))))
 '(hl-line ((t (:background "steel blue"))))
 '(idle-highlight ((t (:inherit region :background "tomato")))))
