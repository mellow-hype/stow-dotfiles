;;; -*- lexical-binding: t -*-
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("972f792651d32b0506481b9e87b2fbc9b732ae9da2527562668c6e7d149fefda"
     default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; PACKAGE MANAGER INIT
(require 'package)
(add-to-list 'package-archives
      '("melpa" . "https://melpa.org/packages/"))

;; bootstrap use-package
(package-initialize)
(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
;; enable global 'ensure t' to always install missing packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;;; LOAD HOST-SPECIFIC CONFIG
;; do this before org-mode setup since this will define org-directory for use below
(load-file (concat "~/.config/emacs/" (system-name) "-config.el"))

;;; ORG MODE
;; default note to append to when capture is triggered
(setq org-default-notes-file (concat org-directory "capture.org"))
;; list of agenda files is stored in this file
(setq org-agenda-files (concat org-directory "agenda-files"))
;; key binds for org stuff
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;;; org-mode hooks
;; always toggle line wrapping mode for org files
(add-hook 'org-mode-hook
          (lambda ()
            (toggle-truncate-lines nil)
            (setq word-wrap t)
            ))

;; org-mode capture templates
(setq org-capture-templates
      '(
        ("t" "Task" entry (file+headline "~/core/org-notes/tasks.org" "Taskbox")
        "* TODO %?\n %i")
        ("r" "Research Task" entry (file+headline "~/core/org-notes/research.org" "Taskbox")
        "* TODO %?\n %i")
        ("i" "Idea" entry (file "~/core/org-notes/capture.org")
        "* IDEA: %?\n %i")
        ("j" "Journal" entry (file+olp+datetree "~/core/org-notes/journal.org")
        "* entry: %U\n %i")
      )
)

;;; EVIL-MODE STUFF
;; load+configure evil-mode
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(use-package evil
    :demand t ;; install the evil package if not installed
    :bind (("<escape>" . keyboard-escape-quit))
    :init ;; set some configuration options before loading
    (setq evil-want-C-u-scroll t)
    :config ;; set evil options after loading
    (evil-mode 1)
    ;; set the leader key to <space>
    (evil-set-leader 'motion (kbd "SPC")))

;; load+enable evil-collection (add vim bindings everywhere)
(use-package evil-collection
    :after evil
    :config
    (evil-collection-init)
    ; make tab work as expected in insert mode
    (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
    ;; window management
    (evil-define-key 'normal 'global (kbd "<leader>vs") 'evil-window-vsplit)
    (evil-define-key 'normal 'global (kbd "<leader>vd") 'evil-window-split)
    ;; save+kill buffer
    (evil-define-key 'normal 'global (kbd "<leader>w") 'save-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer)
    ;; buffer cycling
    (evil-define-key 'normal 'global (kbd "<leader>bb") 'previous-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>bn") 'next-buffer))

;; commentary clone
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;; surround clone
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))


;; improved search and navigation features w/ consult
(use-package consult
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  :config
  (dolist (src consult-buffer-sources)
  (unless (eq src 'consult--source-buffer)
      (set src (plist-put (symbol-value src) :hidden t))))
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any)
   ))

;; improved autocomplete panel w/ vertico
(use-package vertico
    :config
    (vertico-mode))

;; add annotations/marginalia to minibuffer/autocomplete
(use-package marginalia
    :bind (:map minibuffer-local-map
            ("M-A" . marginalia-cycle))
    :init
    (marginalia-mode))

;;; LOOK AND FEEL
;; which-key package
;; set theme
(use-package zenburn-theme)
(use-package gruvbox-theme)
(load-theme 'gruvbox-dark-medium t)
;; highlight active line w/ cursor
(global-hl-line-mode 1)

;; disable bulky ui elements
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(setq scroll-bar-mode nil)
;; line numbers
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;;; BEHAVIOR
;; tab settings
(setq-default indent-tabs-mode nil) ; insert spaces instead of real tab
(setq-default tab-width 4) ; default width is 4

;;; KEY BINDS
;; Global key binds

;; evil leader binding for file finder
(evil-define-key 'normal 'global (kbd "<leader>cf") 'consult-find)
(evil-define-key 'normal 'global (kbd "<leader>fr") 'consult-recent-file)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)
;; evil leader binding for file ripgrep
(evil-define-key 'normal 'global (kbd "<leader>fs") 'consult-ripgrep)
;; leader bind for buffer search
(evil-define-key 'normal 'global (kbd "<leader>fb") 'consult-buffer)

;; init evil-collection at global scope
(evil-collection-init)
