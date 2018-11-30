# racket-camera

## Usage

To use single shot capture (slowly but safety).
```racket

(require racket-camera)

;; Check web camera devices.
(get-capture-device-name-list)
;=> '((0 . "TOSHIBA Web Camera - HD") (1 . "Logicool Webcam C930e"))

; Single shot capture on device 0 (return image)
(single-capture 0)
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
