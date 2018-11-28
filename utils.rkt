#lang racket
(require picturing-programs)
(require ffi/unsafe
         ffi/cvector)
(require "escapi.rkt")

(provide buf->image
         get-capture)

;; number number number -> image
(define (buf->image buf width height)
  (local [(define (make-pixel x y)
            (color (cvector-ref buf (+ (+ (* x 4) 2) (* y width 4)))
                   (cvector-ref buf (+ (add1 (* x 4)) (* y width 4)))
                   (cvector-ref buf (+ (* x 4) (* y width 4)))))]
    (build-image width height make-pixel)))

;; number number number -> image
(define (get-capture cam-no width height)
  (and (< 0 (count-capture-devices))
       (< cam-no (count-capture-devices))
       (let* ([buf (make-cvector _uint8 (* width height 4))]
              [strc (make-SimpleCapParams buf width height)])
         (init-capture cam-no strc)
         (do-capture cam-no)
         (buf->image buf width height)
         (deinit-capture cam-no)
         (buf->image buf width height))))
