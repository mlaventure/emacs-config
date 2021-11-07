;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kenfe-Mickael Laventure"
      user-mail-address "mickael.laventure@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 20))
;; (setq doom-unicode-font (font-spec :family "Hack Regular Nerd Font Complete Mono" :size 20))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; default to python3
(add-hook! python-mode
  (setq python-shell-interpreter "python3"))

;; no auto format for c/c++. The codebase hasn't it applied everywhere yet.
(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode sql-mode tex-mode latex-mode c-mode cc-mode cpp-mode c++-mode))

;; make gc comment or uncomment a line
(use-package! evil-nerd-commenter
  :commands (evilnc-comment-or-uncomment-lines))

(map! :nv "gc" #'evilnc-comment-or-uncomment-lines)

;; Change the color of the 80 column marker
(custom-set-faces! '(hl-fill-column-face :background "purple"))

;; recognize my go template using pongo2
(use-package! web-mode
  :mode "\\.cppt\\'"
  :mode "\\.got\\'"
  :mode "\\.ht\\'"
  :mode "\\.pyt\\'"
  :config
  (add-to-list 'web-mode-engines-alist '("django" . "\\.cppt\\'"))
  (add-to-list 'web-mode-engines-alist '("django" . "\\.got\\'"))
  (add-to-list 'web-mode-engines-alist '("django" . "\\.ht\\'"))
  (add-to-list 'web-mode-engines-alist '("django" . "\\.pyt\\'")))

;; Set frame opacity to 90%
(add-to-list 'default-frame-alist '(alpha . 90))

;; show help faster
(after! which-key
  (setq which-key-idle-delay 1.0))

;; use counsel-evil-marks
(use-package! counsel
  :init
  (define-key!
    [remap evil-show-marks] #'counsel-evil-marks))

;; activate line on bitbake files
;; (use-package! bitbake-modes
;;   :hook (bitbake-mode . display-line-numbers-mode))

(add-hook! bitbake-mode
           'display-line-numbers-mode)

;; 50 is too short for me, set it to 72 which is also the limit on github
(use-package! git-commit
  :config
  (setq git-commit-summary-max-length 72))

(defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package! go-mode
  :defer t
  :after lsp-mode
  ;; :hook (go-mode . lsp-go-install-save-hooks)
  :config
  (setq lsp-go-use-gofumpt t))

;; (add-hook! go-mode
;;            (add-hook! 'before-save-hook #'lsp-organize-imports t t))

;; (after! go-mode
;;       (add-hook! 'before-save-hook #'lsp-organize-imports t t))

  ;;     (setq lsp-go-use-gofumpt t)
  ;;     (add-hook 'before-save-hook #'lsp-organize-imports t t)))
