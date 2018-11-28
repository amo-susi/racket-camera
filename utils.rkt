#lang racket
(require picturing-programs)
(require ffi/unsafe
         ffi/cvector)
(require "escapi.rkt")

(provide buf->image
         single-capture)

;; number number number -> image
(define (buf->image buf width height)
  (local [(define (make-pixel x y)
            (color (cvector-ref buf (+ (+ (* x 4) 2) (* y width 4)))
                   (cvector-ref buf (+ (add1 (* x 4)) (* y width 4)))
                   (cvector-ref buf (+ (* x 4) (* y width 4)))))]
    (build-image width height make-pixel)))

;; number number number -> image
(define (single-capture cam-no width height)
  (and (< 0 (count-capture-devices))
       (< cam-no (count-capture-devices))
       (let* ([buf (make-cvector _uint8 (* width height 4))]
              [strc (make-SimpleCapParams buf width height)])
         (init-capture cam-no strc)
         (do-capture cam-no)
         (do ([num 0 (add1 num)])
           ((or (> num 10)
                (= 1 (is-capture-done cam-no)))
            (deinit-capture cam-no))
           (sleep 0.5))
         (buf->image buf width height))))
