# racket-camera

## Usage

To use single shot capture (slowly but safety).
```racket

(require racket-camera)

;; Check web camera devices.
(get-capture-device-name-list)
;=> '((0 . "TOSHIBA Web Camera - HD") (1 . "Logicool Webcam C930e"))

; Single shot capture on device 0 as width 640 and height 480.
(single-capture 0)
;=> image

; Single shot capture on device 1 as width 1920 height and height 1080.
(single-capture 1 #:width 1920 #:height 1080)
;=> image

```

## Installation
Use the raco package install.

    $ raco pkg install https://github.com/a-nano/racket-camera.git

## Author

* Akihide Nano (an74abc@gmail.com)

## Copyright

Copyright (c) 2018 Akihide Nano (an74abc@gmail.com)

## License

Licensed under the LLGPL License.
