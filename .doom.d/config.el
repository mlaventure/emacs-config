;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kenfe-Mickael Laventure"
      user-mail-address "mickael.laventure@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; default to python3
(add-hook! python
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
;; (set-frame-parameter nil 'alpha '(100 . 90)) ;; 100 if active 90% if not
;; (set-frame-parameter nil 'alpha 90)
;; (set-frame-parameter nil 'alpha-background 80)
(add-to-list 'default-frame-alist '(alpha . '(100 . 90)))
(add-to-list 'default-frame-alist '(alpha-background . 90))

;; show help faster
(after! which-key
  (setq which-key-idle-delay 1.0))

;; use counsel-evil-marks
;; (use-package! counsel
;;   :init
;;   (define-key!
;;     [remap evil-show-marks] #'counsel-evil-marks))

;; activate line on bitbake files
;; (use-package! bitbake-modes
;;   :hook (bitbake-mode . display-line-numbers-mode))

(add-hook! bitbake-modes
           'display-line-numbers-mode)

;; 50 is too short for me, set it to 72 which is also the limit on github
(use-package! git-commit
  :config
  (setq git-commit-summary-max-length 72))

(defun lsp-go-install-save-hooks ()
    (add-hook 'before-save-hook #'lsp-organize-imports))

(use-package! go-mode
  :defer t
  :after lsp-mode
  ;; :hook (go-mode . lsp-go-install-save-hooks)
  :config
  (setq lsp-go-use-gofumpt t))

;; (defun lsp-go-install-save-hooks ()
;;   (add-hook 'before-save-hook #'lsp-format-buffer t t)
;;   (add-hook 'before-save-hook #'lsp-organize-imports t t))
;; (add-hook! go-mode #'lsp-go-install-save-hooks)

;; (add-hook! go-mode
;;            (add-hook! 'before-save-hook #'lsp-organize-imports t t))

;; (after! go-mode
;;       (add-hook! 'before-save-hook #'lsp-organize-imports t t))

  ;;     (setq lsp-go-use-gofumpt t)
  ;;     (add-hook 'before-save-hook #'lsp-organize-imports t t)))

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(after! lsp-rust
  (setq lsp-rust-analyzer-display-chaining-hints t
  lsp-rust-analyzer-display-parameter-hints t
  lsp-rust-analyzer-server-display-inlay-hints t))

;; lsp-mode uses the projectile root to determine the root of the go project.
;; Add "go.mod" to the list of considered file so it's found instead of the top
;; .git directory
;; (after! projectile
;;   (add-to-list 'projectile-project-root-files "go.mod"))

;; (after! projectile
;;   (setq projectile-project-root-files
;;         (append projectile-project-root-files-bottom-up
;;                 projectile-project-root-files '("go.mod"))
;;         projectile-project-root-files-bottom-up nil))

;; (after! projectile
;;   (add-to-list 'projectile-project-root-files-top-down-recurring "go.mod")
;;   (setq projectile-project-root-functions '(projectile-root-local projectile-root-top-down-recurring projectile-root-top-down projectile-root-bottom-up)))

(use-package! projectile
  :config
  (add-to-list 'projectile-project-root-files-top-down-recurring "go.mod")
  (setq projectile-project-root-functions '(projectile-root-local projectile-root-top-down-recurring projectile-root-top-down projectile-root-bottom-up)))

(use-package! lsp
  :after projectile)
