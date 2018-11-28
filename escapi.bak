#lang racket
(require "config.rkt")
;(require racket-camera/config)

(require ffi/unsafe
         ffi/cvector)

;(define racket-camera-dylib-path (ffi-lib "escapi3/bin/win64/escapi")) ;; for test

(provide init-capture
         deinit-capture
         do-capture
         count-capture-devices
         is-capture-done
         
         make-SimpleCapParams)

;; Target buffer.
(define-cstruct _SimpleCapParams
  ([mTargetBuf _cvector]
   ; Buffer width
   [mWidth _int]
   ; Buffer height
   [mHeight _int]))


#|
; Sets up the ESCAPI DLL and the function pointers below. Call this first!
; Returns number of capture devices found (same as countCaptureDevices, below)

(define setup-escapi 
  (get-ffi-obj 'setupESCAPI racket-camera-dylib-path
               (_fun -> _int)))
|#

;; return the number of capture devices found
(define count-capture-devices
  (get-ffi-obj 'countCaptureDevices racket-camera-dylib-path
               (_fun -> _int)))

#|
 initCapture tries to open the video capture device. 
  Returns 0 on failure, 1 on success. 
  Note: Capture parameter values must not change while capture device
        is in use (i.e. between initCapture and deinitCapture).
       Do *not* free the target buffer, or change its pointer!
|#

(define init-capture
  (get-ffi-obj 'initCapture racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     [a-params : _SimpleCapParams-pointer]
                     -> _int)))

;; deinitCapture closes the video capture device.
(define deinit-capture
  (get-ffi-obj 'deinitCapture racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     -> _void)))

;; doCapture requests video frame to be captured.
(define do-capture
  (get-ffi-obj 'doCapture racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     -> _void)))

;; isCaptureDone returns 1 when the requested frame has been captured.
(define is-capture-done
  (get-ffi-obj 'isCaptureDone racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     -> _int)))

;; Get the user-friendly name of a capture device.
(define get-capture-device-name
  (get-ffi-obj 'getCaptureDeviceName racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     [namebuffer : _cvector]
                     [bufferlength : _int]
                     -> _void)))

;; (define namebuffer (make-cvector _byte 256))
;; (ge-capture-device-name 0 namebuffer (cvector-length namebuffer))

;; Returns the ESCAPI DLL version. 0x200 for 2.0 and later (for legacy support)
(define escapi-dll-version
  (get-ffi-obj 'ESCAPIDLLVersion racket-camera-dylib-path
               (_fun -> _int)))

#|
  On properties -
  - Not all cameras support properties at all.
  - Not all properties can be set to auto.
  - Not all cameras support all properties.
  - Messing around with camera properties may lead to weird results, so YMMV.
|#

#|
;; Gets value (0..1) of a camera property (see CAPTURE_PROPERTIES, above)
(define get-capture-property-value-proc
  (get-ffi-obj 'getCapturePropertyValueProc racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     [prop : _int]


;; Gets whether the property is set to automatic (see CAPTURE_PROPERTIES, above)
(define get-capture-property-auto-proc
  (get-ffi-obj 'getCapturePropertyAutoProc racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     [prop : _int]
                     -> _int)))
                     -> _float)))

;; Set camera property to a value (0..1) and whether it should be set to auto.
(define set-capture-property-proc
  (get-ffi-obj 'setCapturePropertyProc racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     [prop : _int]
                     [value : _float]
                     [autoval : _int]
                     -> _int)))
|#

#|
  All error situations in ESCAPI are considered catastrophic. If such should
  occur, the following functions can be used to check which line reported the
  error, and what the HRESULT of the error was. These may help figure out
  what the problem is.


;; Return line number of error, or 0 if no catastrophic error has occurred.
(define get-capture-error-line-proc
  (get-ffi-obj 'getCaptureErrorLineProc racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     -> _int)))


;; Return HRESULT of the catastrophic error, or 0 if none.
(define get-capture-error-code-proc
  (get-ffi-obj 'getCaptureErrorCodeProc racket-camera-dylib-path
               (_fun [deviceno : _uint]
                     -> _int)))
|#
