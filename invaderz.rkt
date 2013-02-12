;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname invaderz) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;robert heemann (THE GREAT VLADIMIR SKOVZKY)
(require 2htdp/image)
(require 2htdp/universe)
;==============================================================================
;INVADERZ FROM THE SPACE: II in space with cowboys destroying them with lasers
;==============================================================================

;==============================================================================
;Physical Constants
(define HEIGHT 700)
(define WIDTH 700)
(define XSHOTS (/ WIDTH 2))



;==============================================================================
;Graphical Constants
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 5 "solid" "red"))
 


;==============================================================================
;Function Definitions

     ;Check-Expects
          ;check-expect tock
(check-expect (tock empty) empty)
(check-expect (tock (cons 1 empty)) (cons (sub1 (first (cons 1 empty))) (tock (rest (cons 1 empty)))))
<<<<<<< HEAD
=======
(check-expect (tock (cons -1 empty)) (tock (rest (cons -1 empty))))
>>>>>>> done

          ;check-expect keyh
(check-expect (keyh empty " ") (cons HEIGHT empty))
(check-expect (keyh (cons 1 empty) " ") (cons HEIGHT (cons 1 empty)))

          ;check-expect to-image
(check-expect (to-image empty) BACKGROUND)
(check-expect (to-image (cons 1 empty)) (place-image  SHOT XSHOTS (first (cons 1 empty))(to-image (rest (cons 1 empty)))))


     ; A ShotWorld is List-of-numbers.
     ; interp.: the collection of shots fired and moving straight up
 
     ; ShotWorld -> ShotWorld
     ; move each shot up by one pixel
(define (tock w)
  (cond
    [(empty? w) empty]
    [(<=(first w) 0) (tock (rest w))]
    [else (cons (sub1 (first w)) (tock (rest w)))]))
 
     ; ShotWorld KeyEvent -> ShotWorld
     ; add a shot to the world if the space bar was hit
(define (keyh w ke)
  (cond
    [(key=? ke " ") (cons HEIGHT w)]
    [else w]))
 
     ; ShotWorld -> Image
     ; add each shot y on w at (MID,y) to the background image
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w) (to-image (rest w)))]))
 
   

;==============================================================================
;Creating The Universe
     ; ShotWorld -> ShotWorld
(define (main w0)
  (big-bang w0
            (on-tick tock)
            (on-key keyh)
            (to-draw to-image)))
