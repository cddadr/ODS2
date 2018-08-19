;(menu-bar-mode -1)
(tool-bar-mode -1)

(defun scroll-up-10-lines ()
  "Scroll up 10 lines"
  (interactive)
  (scroll-up 10))

(defun scroll-down-10-lines ()
  "Scroll down 10 lines"
  (interactive)
  (scroll-down 10))

(global-set-key (kbd "<mouse-4>") 'scroll-down-10-lines) ;
(global-set-key (kbd "<mouse-5>") 'scroll-up-10-lines) ;

(add-hook 'term-mode-hook
          (lambda () (face-remap-add-relative 'default :family "Liberation Mono")))
(add-hook 'dired-mode-hook
          (lambda () (face-remap-add-relative 'default :family "Liberation Mono")))
(add-hook 'org-mode-hook
          (lambda () (face-remap-add-relative 'default :family "Liberation Mono")))
(add-hook 'calendar-mode-hook
          (lambda () (face-remap-add-relative 'default :family "Liberation Mono")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#434149" :foreground "#FFFFFFFFFFFF" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "Adobe" :family "Helvetica"))))
 '(custom-button ((t (:background "#746b6c" :foreground "white" :box (:line-width 1 :style released-button)))))
 '(custom-button-mouse ((t (:background "#746b6c" :foreground "white" :box (:line-width 1 :style released-button)))))
 '(custom-button-pressed ((t (:background "#746b6c" :foreground "white" :box (:line-width 1 :style pressed-button)))))
 '(fixed-pitch ((t (:family "lucidatypewriter"))))
 '(fixed-pitch-serif ((t (:family "Courier"))))
 '(fringe ((t (:background "#5a555a"))))
 '(highlight ((t (:background "#da70a0"))))
 '(menu ((t (:background "#746b6c"))))
 '(mode-line ((t (:background "#8b7183" :foreground "white" :box (:line-width 1 :style released-button)))))
 '(mode-line-buffer-id ((t (:slant oblique :weight bold))))
 '(mode-line-highlight ((t (:box (:line-width 1 :color "grey40" :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#746b6c" :foreground "white" :box (:line-width 1 :style released-button) :weight light))))
 '(scroll-bar ((t (:background "#877c7c"))))
 '(variable-pitch ((t (:family "helvetica")))))
