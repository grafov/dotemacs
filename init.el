;;; -*- lexical-binding: t; -*-

;; Copyright (C) 2014-2015  Alexander I.Grafov (axel)

;; Author: Alexander I.Grafov (axel) <grafov@gmail.com>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(package-initialize nil)

;; system 
(let ((default-directory user-emacs-directory))
  (normal-top-level-add-to-load-path '("site-lisp")))
(let ((default-directory (concat user-emacs-directory "site-lisp")))
  (normal-top-level-add-subdirs-to-load-path))

;; My additional files with specific configs
(load-file (concat user-emacs-directory "init-locale.el"))
(load-file (concat user-emacs-directory "init-my.el"))
 
;; Variables configured via UI
(setq custom-file (concat user-emacs-directory "init-custom.el"))
(load custom-file)

;; Default and per-save backups go here:
(setq version-control t     ;; Use version numbers for backups.
      kept-new-versions 10  ;; Number of newest versions to keep.
      kept-old-versions 2   ;; Number of oldest versions to keep.
      delete-old-versions t ;; Don't ask to delete excess backup versions.
      backup-by-copying t)  ;; Copy all files, don't rename them.
(setq backup-directory-alist '(("" . "/home/axel/.emacs.d/backups")))

(package-initialize t)
(setq package-enable-at-startup nil)

                                        ; Add package sources
(unless (assoc-default "elpa" package-archives)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t))
(unless (assoc-default "marmalade" package-archives)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (package-refresh-contents))

;; install and load packages
;;
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant

(use-package auto-compile
   :ensure t)
;;   :init (auto-compile-on-load-mode))

;; experiments with Frames & Windows behaviour
;;
(setq pop-up-frames 'graphics)
(set 'org-agenda-window-setup 'other-frame)
(set 'org-src-window-setup 'other-frame)
;(require 'autofit-frame)
;(add-hook 'after-make-frame-functions 'fit-frame)
;(eval-after-load "window" '(require 'window+))
;; Focus follows mouse off to prevent crazy things happening when I click on
;; e.g. compilation error links.
(set 'mouse-autoselect-window t)
(set 'focus-follows-mouse nil)
;; kill frames when a buffer is buried, makes most things play nice with
;; frames
(set 'frame-auto-hide-function 'delete-frame)
;(set-frame-parameter (selected-frame) 'internal-border-width 0)
;; One on One Emacs странно работает, нужно разбираться
;
;(require 'oneonone))
;(1on1-emacs) - зачем-то сменяет тему оформления

(require 'calendar)

;; keychain
;;
(use-package keychain-environment
 :config (keychain-refresh-environment))

(use-package undo-tree
  :diminish undo-tree-mode)

;; smart-mode-line
;;
(use-package smart-mode-line
  :ensure t)
(use-package smart-mode-line-powerline-theme
  :ensure t
  :requires smart-mode-line
  :config (progn
          (sml/setup)
          (powerline-center-theme)))

;; edit-server (emacs daemon)
;;
(require 'edit-server)
(edit-server-start)
(server-start)

;; Helm
;;
(use-package helm
  :ensure helm
  :bind (("C-x C-f" . helm-find-files))
  :config (progn
            (require 'helm-config)
            (require 'helm-tags)
            (helm-mode 1))
  :diminish helm-mode)

(use-package helm-projectile)

;; projectile 
;; + helm bindings
;;
(use-package projectile
  :ensure t
  :requires (helm helm-projectile)
  :bind (("<f2>" . projectile-commander)
         ("<f12>" . projectile-commander)
         ("C-x p" . helm-projectile-switch-project)
         ("C-," . helm-projectile-switch-to-buffer))
  :config (progn
          (projectile-global-mode)
          (helm-projectile-on)))

;; undo-tree
;;
(use-package undo-tree
  :ensure t
  :config (progn
          (global-undo-tree-mode)
          (setq undo-tree-visualizer-timestamps t)
          (setq undo-tree-visualizer-diff t)))

;; iedit (site-lisp)
;;
(use-package iedit
  :bind (("C-:" . iedit-mode)))

;; company 
;;
(use-package company
  :ensure t
  :defer t
  :init    (add-hook 'prog-mode-hook 'company-mode)
  :config (progn
    (setq company-tooltip-limit 20)                      ; bigger popup window
    (setq company-idle-delay .5)                         ; decrease delay before autocompletion popup shows
    (setq company-echo-delay 0)                          ; remove annoying blinking
    (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
    (global-company-mode))
  :diminish company-mode)

;; company-go (local)
;;
(use-package company-go
  :ensure t)

;; C-M-e in minibuffer to enter mode  
(use-package miniedit
  :commands minibuffer-edit
  :init (miniedit-install))

;; Yasnippet
;;
;(require 'yasnippet)
;(yas-global-mode 1)
(use-package yasnippet
 :ensure t
 :diminish yas-minor-mode
; :init
; (progn
;   (eval-after-load "yasnippet" '(add-to-list 'yas-snippet-dirs "/home/axel/.emacs.d/yasnippet/"))
;   (add-hook 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
;   (setq yas-key-syntaxes '("w_" "w_." "^ "))
;   (setq yas-installed-snippets-dir "/home/axel/.emacs.d/yasnippet")
;   (setq yas-expand-only-for-last-commands '(self-insert-command))
                                        ;   (yas-global-mode 1)
                                         ;   )
 :config (progn
         ;  (add-to-list 'yas-prompt-functions 'shk-yas/helm-prompt)
           (yas-global-mode 1)))


(defun shk-yas/helm-prompt (prompt choices &optional display-fn)
  "Use helm to select a snippet. Put this into `yas/prompt-functions.'"
  (interactive)
  (setq display-fn (or display-fn 'identity))
  (if (require 'helm-config)
      (let (tmpsource cands result rmap)
        (setq cands (mapcar (lambda (x) (funcall display-fn x)) choices))
        (setq rmap (mapcar (lambda (x) (cons (funcall display-fn x) x)) choices))
        (setq tmpsource
              (list
               (cons 'name prompt)
               (cons 'candidates cands)
               '(action . (("Expand" . (lambda (selection) selection))))
               ))
        (setq result (helm-other-buffer '(tmpsource) "*helm-select-yasnippet"))
        (if (null result)
            (signal 'quit "user quit!")
          (cdr (assoc result rmap))))
    nil))

;; Golang
;;
(use-package go-mode
  :ensure t
  :config (progn
              (if (get-process "gocode") nil (shell-command "gocode"))
              (setenv "GOPATH" (concat (getenv "HOME") "/go"))
              (setenv "GOPATH" (concat (getenv "GOPATH") ":" (getenv "HOME") "/prj"))
              (setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/go/bin"))
              (add-hook 'before-save-hook #'gofmt-before-save)
              (add-hook 'go-mode-hook (lambda ()
                                        (go-eldoc-setup)
;;                                        (set (make-local-variable 'company-backends) '(company-go))
                                        (local-set-key (kbd "M-.") 'godef-jump)
                                        ))))
                                        ;;                                        (company-mode)
(load-file "/home/axel/go/src/golang.org/x/tools/cmd/oracle/oracle.el")
(load-file "/home/axel/prj/my/go-playground/go-playground.el")

(require 'go-complete)
(add-hook 'completion-at-point-functions 'go-complete-at-point)


;; (use-package go-projectile
;;   :ensure t
;;   :requires (projectile go-mode))

(require 'go-projectile)

;; Go + Flycheck
(use-package flycheck
  :ensure t)
;(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")
;(require 'go-flycheck)

;; Jedi for python
;;
(use-package jedi
  :ensure t
  :init (progn
          (add-hook 'python-mode-hook 'jedi:setup)
          (setq jedi:complete-on-dot t)))

;; Org-mode
;;
(use-package org
  :ensure t
  :requires helm
  :bind (("C-c a" . org-agenda)))

(add-hook 'org-mode-hook
          #'(lambda ()
              (define-key org-mode-map (kbd "C-,") nil)
              (define-key org-mode-map (kbd "C-,") 'helm-projectile-switch-to-buffer)))
(setq org-hide-leading-stars 1)
;; Преобразование таблиц org в markdown.
;; I described it http://stackoverflow.com/questions/14275122/editing-markdown-pipe-tables-in-emacs/20912535#20912535
;; Usage Example:
;;
;; <!--- BEGIN RECEIVE ORGTBL ${1:YOUR_TABLE_NAME} -->
;; <!--- END RECEIVE ORGTBL $1 -->
;;
;; <!---
;; #+ORGTBL: SEND $1 orgtbl-to-gfm
;; | $0 |
;; -->
(defun orgtbl-to-gfm (table params)
  "Convert the Orgtbl mode TABLE to GitHub Flavored Markdown."
  (let* ((alignment (mapconcat (lambda (x) (if x "|--:" "|---"))
                               org-table-last-alignment ""))
         (params2
          (list
           :splice t
	   :hline (concat alignment "|")
           :lstart "| " :lend " |" :sep " | ")))
    (orgtbl-to-generic table (org-combine-plists params2 params))))

;; Eldoc
(use-package eldoc
  :diminish eldoc-mode
  :commands turn-on-eldoc-mode
  :init
  (progn
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))


;; Mark fixme, todo etc
;;
(use-package fic-mode
  :ensure t
  :init (progn
          (fic-mode)
          (turn-on-fic-mode)))

(use-package restclient
  :ensure t)

(use-package web-beautify
  :ensure t)

(use-package slime
  :ensure t
  :config (add-hook 'css-mode-hook
          (lambda ()
            (define-key css-mode-map "\M-\C-x" 'slime-js-refresh-css)
            (define-key css-mode-map "\C-c\C-r" 'slime-js-embed-css))))

(use-package slime-company
  :ensure t
  :requires company)

(use-package js2-mode  
  :ensure t
  :requires slime
  :config (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode)))

;; Magit for git
;;
(use-package magit
  :ensure t
  :bind (("<f8>" . magit-status)))
(setq magit-last-seen-setup-instructions "1.4.0")

;; Plantuml
;;
;(use-package plantuml-mode
;  :ensure t)

;; override default keybindings
(load-file (concat user-emacs-directory "init-keybindings.el"))

(require 'org-notmuch)

(use-package org-bullets
  :ensure t
  :config (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (require 'org-projectile)
;; (setq org-projectile:projects-file
;;       "/home/axel/org/todo.org")
;; (add-to-list 'org-capture-templates (org-projectile:project-todo-entry))
;; ;(setq org-agenda-files (append org-agenda-files (org-projectile:todo-files)))

(provide 'init)

;;; init.el ends here
