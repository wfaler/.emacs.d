(require 'package)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)
(column-number-mode)
(server-start)
(add-to-list 'load-path "~/.emacs.d/ensime_2.10.0-0.9.8.9/elisp")
;; NO FRILLS
(dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
  (when (fboundp mode) (funcall mode -1)))
(setq inhibit-startup-screen t)
;; NO JUNK
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
      backup-directory-alist `((".*" . ,temporary-file-directory)))
;; EL-GET
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
(defun el-get-sync-recipes (overlay)
  (let* ((recipe-glob (locate-user-emacs-file (concat overlay "/recipes/*.rcp")))
         (recipe-files (file-expand-wildcards recipe-glob))
         (recipes (mapcar 'el-get-read-recipe-file recipe-files)))
    (mapcar (lambda (r) (add-to-list 'el-get-sources r)) recipes)
    (el-get 'sync (mapcar 'el-get-source-name recipes))))
(setq el-get-user-package-directory user-emacs-directory)
;; EL-GET SYNC OVERLAYS
(el-get-sync-recipes "el-get-haskell")
(el-get-sync-recipes "el-get-user")
;; CUSTOM FILE
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)


(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
                          "[ \t\n]*$"
                          ""
                          (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

(load-theme 'solarized-dark t)

(require 'ensime)

(require 'scala-mode2)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(setq-default indent-tabs-mode nil)



(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js2-indent-level 2)

(global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))
