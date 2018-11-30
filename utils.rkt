#lang racket
(provide buf->image
         single-capture
         get-capture-device-name-list)

(require picturing-programs)
(require ffi/unsafe
         ffi/cvector)
(require "escapi.rkt")

;; cvector number number -> image
(define (buf->image buf width height)
  (local [(define (make-pixel x y)
            (color (cvector-ref buf (+ (+ (* x 4) 2) (* y width 4)))
                   (cvector-ref buf (+ (add1 (* x 4)) (* y width 4)))
                   (cvector-ref buf (+ (* x 4) (* y width 4)))))]
    (build-image width height make-pixel)))

;; test
(module+ test

  (require rackunit)

  (check-true
   (let ([buf (list->cvector (make-list 400 255) _uint8)])
     (image? (buf->image buf 10 10)))))

;; -> listof pair (number . string)
(define (get-capture-device-name-list)
  (when (< 0 (count-capture-devices))
    (let ([buf (list->cvector (make-list 256 0) _byte)])
      (for/list ([i (in-range (count-capture-devices))])
        (cons i (bytes->string/utf-8 (apply bytes
                                            (filter positive?
                                                    (cvector->list
                                                     (begin (get-capture-device-name i buf 256)
                                                            buf))))))))))

;; test
(module+ test
  (check-true (list? (get-capture-device-name-list))))


;; number #:width [number 640]  #:height [number 480] -> image
(define (single-capture cam-no #:width [width 640] #:height [height 480])
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

;; test
(module+ test
  (check-true (image? (single-capture 0 #:width 640 #:height 480))
              (image? (single-capture 0))))