#lang racket

(provide racket-camera-path
         racket-camera-version
         racket-camera-dylib-path)

;; Module constants
(define racket-camera-path (collection-path "racket-camera"))
(define racket-camera-version "1.0.0")

;; Load dll under windows.
(define racket-camera-dylib-file
  (cond ((equal? (system-type 'os) 'windows) "escapi.dll")
        (else (error "Only windows supported."))))
(define racket-camera-dylib-path (build-path racket-camera-path racket-camera-dylib-file))


;; Add the dll directory to the system path:
(when (equal? (system-type 'os) 'windows)
  (putenv "PATH" (string-append (path->string racket-camera-path) ";" (getenv "PATH"))))

