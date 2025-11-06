;;; -*- lexical-binding: t -*-
;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e8bd9bbf6506afca133125b0be48b1f033b1c8647c628652ab7a2fe065c10ef0"
     "972f792651d32b0506481b9e87b2fbc9b732ae9da2527562668c6e7d149fefda"
     default))
 '(package-selected-packages
   '(consult doom-modeline doom-themes evil-collection evil-commentary
             evil-surround gruvbox-theme marginalia obsidian vertico
             xeft zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; Reconfigured auto-save and backup files to not be created in local dirs
;; backup files
(setq backup-directory-alist `(("." . ,(expand-file-name "tmp/backups/" user-emacs-directory))))
;; auto-save-mode doesn't create the path automatically!
(make-directory (expand-file-name "tmp/auto-saves/" user-emacs-directory) t)
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
    auto-save-file-name-transforms `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

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

;;; ============================================================================
;;; ORG MODE
;; file used to define which files to use for the agenda
(setq org-agenda-files (concat org-directory "/agenda-files"))
;; default note to append to when capture is triggered
(setq org-default-notes-file (concat org-directory "/capture.org"))
(setq my-org-tasks-file (concat org-directory "/tasks.org")) ;; custom: org tasks file
(setq my-org-journal-file (concat org-directory "/journal.org")) ;; custom: org journal file
(setq org-startup-indented 1) ;; always start org mode in indented mode

;; GLOBAL key binds for org stuff (apply even when not in org-mode)
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
;; custom function binding to open bookmarked org files
(global-set-key (kbd "C-c f") 'hypr-org-jump-files)

;; autoinsert header for org files
(define-skeleton my-org-file-frontmatter
    "Autoheader for new org files."
    "Title: "
    "#+TITLE: " str \n
    "#+DATE: " '(call-interactively 'org-time-stamp) "\n\n")

;; custom function to quickly open some org files
(defun hypr-org-jump-files (choice)
  "Choices for bookmarks file to open"
  (interactive "cOpen [c]apture.org | [t]asks.org | [j]ournal.org")
  (cond
   ((eq choice ?c)
    (find-file org-default-notes-file)
      (message "Opened: %s" (buffer-name)))
   ((eq choice ?t)
    (find-file my-org-tasks-file)
      (message "Opened: %s" (buffer-name)))
   ((eq choice ?j)
    (find-file my-org-journal-file)
    (message "Opened: %s" (buffer-name)))
   (t (message "Quit"))))

;; org-mode capture templates
(setq org-capture-templates
      ;; TODO: add template for 'quick-note' to insert into capture file under "Notes" node
      ;; template for todo items
    '(("t" "Todo" entry (file+headline my-org-tasks-file "Taskbox")
        "* TODO %?\n %i")
      ;; template for journal entries
      ("j" "Journal" entry (file+olp+datetree my-org-journal-file)
      "* entry: %U\n %i")))

;; handle settings which can only be set once we know org has been loaded
(use-package org
  :demand t
  :after consult
  :mode (("\\.org$" . org-mode))
  :init
  (setq org-startup-indented 1) ;; always start org mode in indented mode
  :config
  (define-key org-mode-map (kbd "M-i b") 'org-insert-structure-template)
  (define-key org-mode-map (kbd "M-g g") 'consult-org-heading))


;;; ============================================================================
;;; AUTO-INSERT MODE CONFIG
;; configure autoinsert
(use-package autoinsert
  :config
  (setq auto-insert-query nil) ;; disable the default auto-inserts 
  (auto-insert-mode 1) ;; enable auto-insert mode globally
  (setq auto-insert-alist nil) ;; remove this to return defaults
  (add-hook 'find-file-hook 'auto-insert) ;; auto-insert template when new files are created
  (add-to-list 'auto-insert-alist '("\\.org\\'" . my-org-file-frontmatter)))

;;; ============================================================================
;;; EVIL-MODE STUFF
;; define a few config variables before loading (won't cause errors)
(setq evil-want-integration t)
(setq evil-want-keybinding nil)

;; load+configure evil-mode
(use-package evil
    :demand t
    :bind (("<escape>" . keyboard-escape-quit))
    :init ;; set some configuration options before loading
    (setq evil-want-C-u-scroll t)
    :config ;; set configs after load
    (evil-mode 1)
    (evil-set-leader 'motion (kbd "SPC")))

;; load+enable evil-collection (add vim bindings everywhere)
(use-package evil-collection
    :after evil
    :config
    (evil-collection-init)
    ;; make redo/undo work as expected
    (evil-set-undo-system 'undo-redo)
    ;; special bindings for insert-mode
    (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
    ;; active window-map mode with leader bind
    (evil-define-key 'normal 'global (kbd "<leader>w") 'evil-window-map)
    ;; leader bindings: split management
    (evil-define-key 'normal 'global (kbd "<leader>vs") 'evil-window-vsplit)
    (evil-define-key 'normal 'global (kbd "<leader>vh") 'evil-window-split)
    ;; leader bindings: buffer management
    (evil-define-key 'normal 'global (kbd "<leader>s") 'save-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>q") 'kill-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>b") 'previous-buffer)
    (evil-define-key 'normal 'global (kbd "<leader>n") 'next-buffer)
    (evil-define-key 'insert 'global (kbd "C-S-v") 'next-buffer)
    )

;; evil-commentary: commentary clone
(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

;; evil-surround: vim-surround clone
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

;;; ============================================================================
;;; NAVIGATION / TELESCOPE / MENUS
;; improved search and navigation features w/ consult
(use-package consult
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  :config
  (recentf-mode 1) ;; enable for recent-file listing
  (dolist (src consult-buffer-sources)
    ;; iterate though the list of consult buffer sources and set the :hidden flag
    ;; on everything that *isn't* a source buffer.
    (unless (eq src 'consult--source-buffer)
      (set src (plist-put (symbol-value src) :hidden t))))
  (consult-customize consult-theme :preview-key '(:debounce 0.3 any))
  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   :preview-key '(:debounce 0.2 any))
  (consult-customize
   consult-man consult-bookmark
   consult-xref consult-recent-file
   consult--source-recent-file consult--source-project-recent-file
   consult--source-bookmark consult--source-file-register
   :preview-key '(:debounce 0.4 any)))

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

;;; ============================================================================
;;; LOOK AND FEEL
;; doom modeline to get a pretty modeline without much work (and without full Doom)
(use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1))

;; doom themes for more niceness without full doom
(use-package doom-themes
    :ensure t
    :custom
    ;; Global settings (defaults)
    (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
    (doom-themes-enable-italic t) ; if nil, italics is universally disabled
    ;; for treemacs users
    (doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
    :config
    (load-theme 'doom-zenburn t)
  
    ;; Enable flashing mode-line on errors
    (doom-themes-visual-bell-config)
    ;; Enable custom neotree theme (nerd-icons must be installed!)
    (doom-themes-neotree-config)
    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config))

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
;;(global-display-line-numbers-mode t)
(use-package display-line-numbers
    :defer
    :hook
    (prog-mode . display-line-numbers-mode)
    (markdown-mode . display-line-numbers-mode)
    (conf-mode . display-line-numbers-mode))

;;; ============================================================================
;;; BEHAVIOR
;; tab settings
(setq-default indent-tabs-mode nil) ; insert spaces instead of real tab
(setq tab-stop-list (number-sequence 0 200 4)) ; Sets tab stops every 4 columns up to 200

;; always toggle line wrapping mode for org files
(add-hook 'org-mode-hook (lambda ()
    (toggle-truncate-lines) ;; wrap long lines intead of truncating
    (word-wrap-whitespace-mode nil)))

;;; ============================================================================
;;; CUSTOM KEY BINDS
;; common leader- based bindings to simulate how things were set up in vim
(evil-define-key 'normal 'global (kbd "<leader>fr") 'consult-recent-file)
(evil-define-key 'normal 'global (kbd "<leader>fs") 'consult-ripgrep)
(evil-define-key 'normal 'global (kbd "<leader>fl") 'consult-line)
(evil-define-key 'normal 'global (kbd "<leader>fd") 'consult-buffer)
(evil-define-key 'normal 'global (kbd "<leader>ff") 'find-file)

;; help/documentation search
(evil-define-key 'normal 'global (kbd "<leader>mi") 'consult-info)
(evil-define-key 'normal 'global (kbd "<leader>mm") 'consult-man)

;; init evil-collection at global scope
(evil-collection-init)

