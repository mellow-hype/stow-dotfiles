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

;;; ORG MODE
;; org directory
(setq org-directory "~/core/org-notes/")
;; default note to append to when capture is triggered
(setq org-default-notes-file (concat org-directory "/capture.org"))
;; key binds for org stuff
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-agenda-files '("~/core/org-notes/capture.org"
                         "~/core/org-notes/tasks.org"
                         "~/core/org-notes/research.org"
                         ))

;; org-mode capture templates
(setq org-capture-templates
      '(
        ;; template for todo items
        ("t" "Task" entry (file+headline "~/core/org-notes/tasks.org" "Taskbox")
        "* TODO %?\n %i")
        ;; research task
        ("r" "Research Task" entry (file+headline "~/core/org-notes/research.org" "Taskbox")
        "* TODO %?\n %i")
        ;; idea entry
        ("i" "Idea" entry (file "~/core/org-notes/capture.org")
        "* IDEA: %?\n %i")
        ;; template for journal entries
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

;;; OBSIDIAN SETUP
;; load+configure obsidian.el
(use-package obsidian
    :demand t
    :config
    (global-obsidian-mode t) ; enable obsidian mode
    (obsidian-backlinks-mode nil) ; disable the backlinks panel by default
    :bind (:map obsidian-mode-map
                ;; create new
                ("C-c C-n" . obsidian-capture) ;; create new note in inbox directory
                ("C-c C-l" . obsidian-insert-link) ;; insert link to another note with menu
                ("C-c C-o" . obsidian-jump) ;; like obsidian's command palette to jump to note
                ("C-c C-g" . obsidian-follow-link-at-point)
                ("C-c C-b" . obsidian-backlinks-mode) ;; toggle backlinks panel
                ("C-c S-o" . obsidian-change-vault) ;; switch active vault
                )
    :custom
    (obsidian-directory "~/core/HACKVAULT.Obidian")
    (obsidian-inbox-directory "10 Inbox")
    (obsidian-daily-notes-directory "12 Daily Notes")
    (obsidian-templates-directory "000.META/Templates")
    (obsidian-links-use-vault-path t) ; use vault paths in links vs. just the name
    (obsidian-create-unfound-files-in-inbox t) ; create unfound linked files in inbox
    (obsidian-backlinks-panel-width 80)
)

;; xeft provides a search-as-you-type interface for searching the notes directory
(use-package xeft
  :after obsidian
  :bind ((:map obsidian-mode-map (("C-c C-f" . xeft))))
  :custom
  (xeft-directory obsidian-directory)
  (xeft-recursive t)
  (xeft-file-filter #'obsidian-file-p)
  (xeft-title-function #'obsidian-file-title-function))

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
(global-set-key (kbd "C-c M-o") 'global-obsidian-mode) ;; toggle obsidian-mode
(global-set-key (kbd "C-c O") 'obsidian-jump) ;; toggle obsidian-mode

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
