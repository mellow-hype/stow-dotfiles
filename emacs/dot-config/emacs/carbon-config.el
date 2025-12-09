
;; set host-specific org-directory base
(setq org-directory "~/core/HACKVAULT.obsidian/000.org-notes/")
;; default capture file for org notes
(setq org-default-notes-file (concat org-directory "/capture.org"))
;; custom variables for common files
(setq my-org-tasks-file (concat org-directory "/tasks.org"))

;;; custom todo keywords
;;; https://orgmode.org/manual/Multiple-sets-in-one-file.html
;;; https://orgmode.org/manual/Fast-access-to-TODO-states.html
;; (setq org-todo-keywords
;;       '((sequence "PENDING(p)" "UPNEXT(u)" "TODO(t)" "WORKING(w)" "|" "DONE(d)") ; basic state workflow
;;         (sequence "FINDING(f)" | "BUG(b)" "SAFE(s)") ; bug workflow (find -> validation -> resolution)
;;         ))
