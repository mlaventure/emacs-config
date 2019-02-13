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
 '(git-gutter:update-interval 2)
 '(package-selected-packages
   (quote
    (racer flycheck-rust rust-mode vlf helm-projectile projectile markdown-mode yaml-mode protobuf-mode toml-mode dockerfile-mode git-gutter-fringe direnv go-playground godoctor go-guru company-go go-eldoc go-mode company flycheck helm-flx flx helm-fuzzier helm undo-tree column-enforce-mode fill-column-indicator spaceline-all-the-icons moe-theme spaceline fancy-battery highlight-thing smartparens which-key neotree buffer-move nlinum default-text-scale all-the-icons rainbow-delimiters diminish auto-compile use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(hl-line ((t (:background "steel blue"))))
 '(idle-highlight ((t (:inherit region :background "tomato")))))
