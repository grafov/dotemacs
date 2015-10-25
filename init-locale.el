(custom-set-variables
 '(current-language-environment "UTF-8")
 '(default-input-method "russian-computer")
 '(keyboard-coding-system 'utf-8-unix)
)

(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'mule-utf-8)

;; Create Cyrillic-CP1251 Language Environment menu item
(set-language-info-alist
"Cyrillic-CP1251" `((charset cyrillic-iso8859-5)
(coding-system cp1251)
(coding-priority cp1251)
(input-method . "cyrillic-jcuken")
(features cyril-util)
(unibyte-display . cp1251)
(sample-text . "Russian (Ðóññêèé) Çäðàâñòâóéòå!")
(documentation . "Support for Cyrillic CP1251."))
'("Cyrillic"))

;; Russian/Latin keyboard switcher
;; by the way described at:
;;   http://gromnitsky.blogspot.com/2011/08/emacs-xkb-xxkb.html
;;(setf (gethash #xfe08 x-keysym-table) (aref (kbd "s-a") 0))
;;(global-set-key (kbd "s-a") 'toggle-input-method)

;; default cursor color for all X frames
(add-to-list 'default-frame-alist '(cursor-color . "green"))

;; toggle the input method and the cursor color in one place
;; (global-set-key
;;  (kbd "s-a") '(lambda ()
;; 								(interactive)
;; 								(toggle-input-method)
;; 								(if window-system
;; 										(set-cursor-color
;; 										 (if current-input-method
;; 												 "red3"
;; 											 "green")))))

(add-hook 'input-method-activate-hook
          '(lambda ()
             (if window-system
                 (set-cursor-color "red"))))
(add-hook 'input-method-inactivate-hook
          '(lambda ()
             (if window-system
                 (set-cursor-color "green"))))

(require 'quail)

(quail-define-package
 "colemacs-russian" "Russian" "ru" nil
 "Russian-keyboard layout assuming that your default
keyboard layout is Colemacs"
 nil t t t t nil nil nil nil nil t)

(quail-define-rules
 ("1" ?№) ("2" ?-) ("3" ?/) ("4" ?\") ("5" ?:) ("6" ?,) ("7" ?.) ("8" ?_) ("9" ??) 
 ("0" ?%) ("-" ?!) ("=" ?\;) ("q" ?й) ("w" ?ц) ("f" ?м) ("p" ?к) ("g" ?е) ("j" ?ь)("l" ?ш) 
 ("u" ?г) ("y" ?щ) (";" ?ж) ("[" ?х) ("]" ?ъ) ("\\" ?\)) ("a" ?ы) ("r" ?ф) ("s" ?ж) 
 ("t" ?у) ("d" ?л) ("h" ?р) ("n" ?а) ("e" ?в) ("i" ?л) ("o" ?о) ("'" ?э) ("z" ?я) ("x" ?ю) 
 ("c" ?б) ("v" ?и) ("b" ?с) ("k" ?п) ("m" ?т) ("," ?ч) ("." ?н) ("/" ?ё) ("~" ?+) ("!" ?1) 
 ("@" ?2) ("#" ?3) ("$" ?4) ("%" ?5) ("^" ?6) ("&" ?7) ("*" ?8) ("\(" ?9) ("\)" ?0) ("_" ?=) 
 ("+" ?\\) ("Q" ?Й) ("W" ?Ц) ("F" ?М) ("P" ?К) ("G" ?Е) ("J" ?Ь) ("L" ?Ш) ("U" ?Г) ("Y" ?Щ) 
 (":" ?З) ("{" ?Х) ("}" ?Ъ) ("|" ?\() ("A" ?Ы) ("R" ?Ф) ("S" ?Ж) ("T" ?У) ("D" ?Л) ("H" ?Р) 
 ("N" ?Т) ("E" ?В) ("I" ?Д) ("O" ?О) ("\"" ?Э) ("Z" ?Я) ("V" ?И) ("X" ?Ю) ("C" ?Б) ("B" ?С) 
 ("K" ?П) ("M"?Т) ("<" ?Ч) (">" ?Н) ("?" ?\,))

(provide 'init-locale)
