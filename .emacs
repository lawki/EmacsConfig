(setq url-proxy-services
	  	   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
			    ("http" . "172.31.100.27:3128")
				  ("https" . "172.31.100.27:3128")))

(setq url-http-proxy-basic-auth-storage
	  	      (list (list "172.31.100.27:3128"
	  	        (cons "Input your LDAP UID !"
					 (base64-encode-string "edcguest:edcguest")))))

; start package.el with emacs
;(require 'package)

;ACE-WINDOW
;(global-set-key (kbd "C-x w") 'ace-window)


;JEDI
;(require 'jedi)
;(require 'jedi-core)
;(jedi:setup)

; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

; initialize package.el
(package-initialize)

; start auto-complete with emacs
(require 'auto-complete)
; do default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

;let's start auto-complete-CLANG with hooks
;(add-to-list 'load-path (concat myoptdir "AC"))
;(require 'auto-complete-config)
;(require 'auto-complete-clang)
;(setq ac-auto-start nil)
;(setq ac-quick-help-delay 0.5)
;;(setq ac-clang-flags
;      (mapcar (lambda (item)(concat "-I " item))
;              (split-string
;	       "/usr/include/c++/5 
;/usr/include/x86_64-linux-gnu/c++/5
;/usr/include/c++/5/backward
;/usr/lib/gcc/x86_64-linux-gnu/5/include
;/usr/local/include,/usr/lib/gcc/x86_64-linux-gnu/5/include-fixed
;/usr/include/x86_64-linux-gnu,/usr/include"
;	       )
;	      )
 ;     )
;; (ac-set-trigger-key "TAB")
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
;;(define-key ac-mode-map  [(control tab)] 'auto-complete)
;(defun my-ac-config ()
;  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
 ; (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  ;(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  ;(add-hook 'css-mode-hook 'ac-css-mode-setup)
  ;(add-hook 'auto-complete-mode-hook 'ac-common-setup)
;  (global-auto-complete-mode t))
;(defun my-ac-cc-mode-setup ()
;  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
;(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
;(my-ac-config)

;this configuration was done by buskel y
;(defun my:auto-complete-clang-init()
;  (require 'auto-complete-clang)
  ;(add-to-list 'ac-sources 'auto-complete-clang)
;  )
;calling this function for c/c++ hooks
;(add-hook 'c++-mode-hook 'my:auto-complete-clang-init)
;(add-hook 'c-mode-hook 'my:auto-complete-clang-init)

					
;let's define a function which initializes auto-complete-c-headers and gets called for c/c++ hooks
(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include")
  )
; now let's call this function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)


					;setting up CLANG_ASYNC

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/elpa/auto-complete-clang-async-20130526.814/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process)
)

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)
; Fix iedit bug in Mac
;(define-key global-map (kbd "C-c ;") 'iedit-mode)

; start flymake-google-cpplint-load
; let's define a function for flymake initialization
;(defun my:flymake-google-init () 
;  (require 'flymake-google-cpplint)
;  (custom-set-variables
;  '(flymake-google-cpplint-command "/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/cpplint"))
;  (flymake-google-cpplint-load)
;)
;(add-hook 'c-mode-hook 'my:flymake-google-init)
;(add-hook 'c++-mode-hook 'my:flymake-google-init)

; start google-c-style with emacs
;(require 'google-c-style)
;(add-hook 'c-mode-common-hook 'google-set-c-style)
;(add-hook 'c-mode-common-hook 'google-make-newline-indent)

; turn on Semantic
;(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
;(defun my:add-semantic-to-autocomplete() 
;  (add-to-list 'ac-sources 'ac-source-semantic)
;)
;(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode 
;(global-ede-mode 1)
; create a project for our program.
;(ede-cpp-root-project "my project" :file "~/demos/my_program/src/main.cpp"
;		      :include-path '("/../my_inc"))
; you can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
;(global-semantic-idle-scheduler-mode 1)

;environment variable for DCLANG_INCLUDE_DIR
;(setenv 'DCLANG_INCLUDE_DIR)

;setting up IRONY MODE
;(setenv "LIBCLANG_LIBRARY" "/opt/llvm/lib")
;(setenv "LIBCLANG_INCLUDE_DIR" "/opt/llvm/include")
;(add-hook 'c++-mode-hook 'irony-mode)
;(add-hook 'c-mode-hook 'irony-mode)
;(add-hook 'objc-mode-hook 'irony-mode)
;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
;(defun my-irony-mode-hook ()
;    (define-key irony-mode-map [remap completion-at-point]
;				    'irony-completion-at-point-async)
;	  (define-key irony-mode-map [remap complete-symbol]
;				      'irony-completion-at-point-async))
;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;setting up company-rony
;(eval-after-load 'company
;    '(add-to-list 'company-backends 'company-irony))

;setting up multi-term
(require 'multi-term)
(setq multi-term-program "/bin/bash")

;setting up bash-completion
;(add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete)
(require 'bash-completion)
(bash-completion-setup)
;setting up BUFFER-FLIP
;(require 'buffer-flip)

;BUFFER-Selection
(global-set-key (kbd "C-x C-b") 'buffer-menu)
(global-set-key (kbd "C-x C-a") 'multi-term)

;LINE-NUMBER_TOGGLE
(require 'linum-off)
