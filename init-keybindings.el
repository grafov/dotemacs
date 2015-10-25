;; default keybindings
;;
(global-set-key (kbd "M-SPC") 'execute-extended-command)

(global-set-key [(XF86Forward)]
                (lambda ()
                  (interactive)
									(next-buffer)))

(global-set-key [(XF86Back)]
                (lambda ()
                  (interactive)
									(previous-buffer)))

(global-set-key [C-tab] 'other-window)

;(global-set-key (kbd "C-x 4") 'split-cross)

(global-set-key (kbd "M-q") 'compact-uncompact-block)
(global-set-key [mouse-7] 'scroll-left)
(global-set-key [double-mouse-7] 'scroll-left)
(global-set-key [mouse-6] 'scroll-right)
(global-set-key [double-mouse-6] 'scroll-right)
(global-set-key [f6] 'electric-buffer-list)

;(global-set-key (kbd "<XF86Favorites>") 'iswitchb-buffer)
;(global-set-key (kbd "C-,") 'wg-switch-to-buffer)

;(global-set-key [(XF86Calculator)] 'calculator)

(global-set-key (kbd "C-x M-s") 'sudo-unset-ro-or-save)
(global-set-key (kbd "C-x M-f") 'sudo-find-file)

(global-set-key (kbd "S-<backspace>") 'undo)

(global-set-key (kbd "<f7>") 'ack-and-a-half)


(global-set-key (kbd "<kp-add>") 'goto-line)
(eval-after-load 'go-mode '(define-key go-mode-map (kbd "C-c i") 'go-goto-imports))
(eval-after-load 'go-mode '(define-key go-mode-map (kbd "C-c d") 'go-remove-unused-imports))

;(global-set-key (kbd "C-x w") 'wg-switch-to-workgroup)

;; Remapped for Colemacs
;; (define-key (current-global-map) (kbd "C-x !")
;;  (lookup-key (current-global-map) (kbd "C-x 1")))
;; (define-key (current-global-map) (kbd "C-x @")
;;  (lookup-key (current-global-map) (kbd "C-x 2")))
;; (define-key (current-global-map) (kbd "C-x #")
;;  (lookup-key (current-global-map) (kbd "C-x 3")))
;; (define-key (current-global-map) (kbd "C-x $")
;;  (lookup-key (current-global-map) (kbd "C-x 4")))
;; (define-key (current-global-map) (kbd "C-x )")
;;  (lookup-key (current-global-map) (kbd "C-x 0")))

;; org-mode-todo
  (global-set-key (kbd "C-c C-o ;") 'ort/capture-todo)
  (global-set-key (kbd "C-c C-o '") 'ort/capture-checkitem)
  (global-set-key (kbd "C-c C-o `") 'ort/goto-todos)

;; c-x c-<key> переход по проекту
(global-set-key (kbd "C-x C-f") 'helm-projectile-find-file-dwim)
(global-set-key (kbd "C-x C-b") 'helm-projectile-switch-to-buffer)

;; c-x <key> глобальные переходы
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'list-buffers)

(global-set-key (kbd "C-x d") 'dired)

(global-set-key (kbd "<f9>") 'projectile-compile-project)
                
(global-set-key (kbd "C-<f5>") (lambda () (interactive) (revert-buffer t t)))
;(global-set-key [f9] 'compile)

(global-set-key (kbd "C-t") 'dabbrev-expand) ;; don't use M-/ since C-/ used for undo

(global-set-key (kbd "M-*") 'pop-tag-mark)

(global-set-key (kbd "M-.") 'find-function)

(global-set-key (kbd "<XF86Search>") 'notmuch)

(provide 'init-keybindings)



