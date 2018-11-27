#lang racket
(require picturing-programs)
(require "escapi.rkt")
(require "utils.rkt")

(provide init-capture
         deinit-capture
         do-capture

         buf->image
         get-capture)

