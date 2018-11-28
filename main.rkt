#lang racket
(require picturing-programs)
(require "escapi.rkt")
(require "utils.rkt")

(provide init-capture
         deinit-capture
         do-capture
         count-capture-devices
         is-capture-done

         buf->image
         single-capture)