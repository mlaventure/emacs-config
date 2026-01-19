;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Kenfe-Mickaël Laventure"
      user-mail-address "mickael@impulselabs.com")

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
(setq doom-font (font-spec :size 15))

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
;; (add-to-list 'default-frame-alist '(alpha . 90))
(add-to-list 'default-frame-alist '(alpha-background . 90))
(doom/set-frame-opacity 95)

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
  (setq git-commit-summary-max-length 75))

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-organize-imports))

(defun kml/run-golangci-lint-fmt ()
  "Run golangci-lint fmt on the current buffer"
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (shell-command (format "golangci-lint fmt %s" filename))
      (revert-buffer t t t))))

;; (use-package! go-mode
;;   :defer t
;;   :after lsp-mode
;;   ;; :hook (go-mode . lsp-go-install-save-hooks)
;;   :config
;;   (setq lsp-go-use-gofumpt t))

(after! go-mode
  (add-hook! 'after-save-hook #'kml/run-golangci-lint-fmt 'append))

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

(after! rustic-lsp
  (add-hook! 'rustic-mode-hook
    (setq lsp-inlay-hints-mode t)
    (setq-local +word-wrap--enable-adaptive-wrap-mode nil)
    (adaptive-wrap-prefix-mode -1)))

(add-hook! 'visual-line-mode-hook
  (if (eq major-mode 'rustic-mode)
      (adaptive-wrap-prefix-mode -1)))

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
  (add-to-list 'projectile-project-root-files-top-down-recurring "Cargo.toml")
  (add-to-list 'projectile-project-root-files-top-down-recurring "go.mod")
  (add-to-list 'projectile-project-root-files-top-down-recurring "platformio.ini")
  (setq projectile-project-root-functions '(projectile-root-local projectile-root-top-down-recurring projectile-root-top-down projectile-root-bottom-up)))

(use-package! lsp
  :after projectile)

(after! sh-script
  :config
  (set-formatter!
    'shfmt
    '("shfmt"
      "--case-indent"
      (unless indent-tabs-mode
        (list "--indent" (number-to-string tab-width)))
      "--language-dialect" (pcase sh-shell (`bash "bash") (`mksh "mksh") (_ "posix"))))
  )

(after! magit
  :config
  (setq  git-commit-summary-max-length 75)
  )

(+global-word-wrap-mode +1)

;; tell impatient mode how to render markdown
(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
           (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://ndossougbe.github.io/strapdown/dist/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
         (current-buffer)))

(persp-mode t)

(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

;; Don’t compact font caches during GC.
(setq inhibit-compacting-font-caches t)

(setq gc-cons-threshold (* 1024 1024 1014)) ;; 100MiB
(setq read-process-output-max (* 8 1024 1024)) ;; 8MiB

(defun venice-api-key ()
  (with-temp-buffer
    (insert-file-contents "~/.venice.key")
    (buffer-substring-no-properties (point-min) (point-max))))

(setq kml/venice-api-key (venice-api-key))

(after! ellama
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (require 'llm-openai)
  (setq llm-warn-on-nonfree nil)
  (setopt ellama-provider
          (make-llm-openai-compatible
           :url "https://api.venice.ai/api/v1"
           :key kml/venice-api-key
           :chat-model "llama-3.3-70b"
           :embedding-model "nomic-embed-text"
           ))
  (setopt ellama-providers
          '(("venice/deepseek-r1" .
             (make-llm-openai-compatible
              :url "https://api.venice.ai/api/v1"
              :key kml/venice-api-key
              :chat-model "deepseek-r1-671b"
              :embedding-model "nomic-embed-text"
              ))
            ("ollama/deepseek-r1" . (make-llm-ollama
                                     :chat-model "deepseek-r1:8b-llama-distill-q8_0")))))

(require 'transient)
;; (require 'ellama)

;; (map! :leader
;;       (:prefix-map ("l" . "ellama")
;;        :desc "Chat"             "C"     #'ellama-chat
;;        :desc "Send last msg"    "L"     #'ellama-chat-send-last-message
;;        :desc "Ask"              "a"     #'ellama-transient-ask-menu
;;        :desc "Code"             "c"     #'ellama-transient-code-menu
;;        :desc "Improve"          "i"     #'ellama-transient-improve-menu
;;        :desc "Make"             "m"     #'ellama-transient-make-menu
;;        :desc "Provider select"  "p"     #'ellama-provider-select
;;        :desc "Session"          "S"     #'ellama-transient-session-menu
;;        :desc "Summarize"        "s"     #'ellama-transient-summarize-menu
;;        :desc "Translate"        "t"     #'ellama-transient-translate-menu
;;        :desc "Context"          "x"     #'ellama-transient-context-menu
;;        (:prefix-map ("T". "Text")
;;         :desc "Text Complete"   "c"     #'ellama-complete
;;         :desc "Text Change"     "C"     #'ellama-change)
;;        (:prefix-map ("r" . "Reasoning")
;;         :desc "Solve reasoning problem"         "r"     #'ellama-solve-reasoning-problem
;;         :desc "Solve domain specific problem"   "d"     #'ellama-solve-domain-specific-problem)
;;        ))

(use-package! lsp-mode
  :config
  (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-enable-file-watchers nil))

;; (use-package! lsp-mode
;;   :config
;;   (lsp-register-client
;;    (make-lsp-client :new-connection (lsp-stdio-connection '("/home/klaventure/.local/bin/ruff" "server" "--verbose"))
;;                     :major-modes '(python-mode) :priority -1 :server-id 'ruff-langserver)))

;; (after! eglot
;;   (add-to-list 'eglot-server-programs
;;                '(python-mode . ("ruff" "server"))))

;; Show the current function name in the header line
;; (which-function-mode)
;; (setq-default header-line-format
;;               '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.
      (assq-delete-all 'which-func-mode mode-line-misc-info))

;; A function to set up our programming-specific display
;;
;;we don't want it enabled globally as that breaks the doom-modeline when
;; copilot-chat is enabled
(defun my-setup-which-function-in-header ()
  "Turn on which-function-mode and display it in the header line."
  ;; Turn on the mode, but only for this buffer.
  (which-function-mode 1)

  ;; Set the header-line-format, but only for this buffer.
  ;; Note: We use `setq-local` instead of `setq-default`. This is the key!
  (setq-local header-line-format
              '((which-func-mode ("" which-func-format " ")))))

;; Now, attach our function to the prog-mode family hook.
;; (add-hook 'prog-mode-hook #'my-setup-which-function-in-header)

(require 'evil-multiedit)
;; (evil-multiedit-default-keybinds)

(after! rustic
  :config
  (add-hook 'rustic-mode-hook
            (lambda ()
              (adaptive-wrap-prefix-mode nil))))

;; accept completion from copilot and fallback to company
;; (after! copilot
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . 'copilot-accept-completion)
;;               ("TAB" . 'copilot-accept-completion)
;;               ("C-TAB" . 'copilot-accept-completion-by-word)
;;               ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; (after! lsp-ui
;;   (setq lsp-ui-doc-enable t))

(after! eglot
  :config
  (setq-default eglot-workspace-configuration
                '((:gopls .
                   ((templateExtensions . '("tmpl")))))))
