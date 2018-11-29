#lang racket
(provide racket-camera-path
         racket-camera-dylib-path)

;; Module constants
(define racket-camera-path (collection-path "racket-camera"))
(define escapi-path (build-path "escapi3" "bin"
                                (if (= (system-type 'word) 64) "win64" "win32")))

;; Load dll under windows.
(define racket-camera-dylib-file
  (cond ((equal? (system-type 'os) 'windows) "escapi.dll")
        (else (error "Only windows supported."))))
(define racket-camera-dylib-path (build-path racket-camera-path escapi-path racket-camera-dylib-file))

;; Add the dll directory to the system path:
(when (equal? (system-type 'os) 'windows)
  (putenv "PATH" (string-append (path->string (build-path racket-camera-path escapi-path)) ";" (getenv "PATH"))))