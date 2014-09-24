(define (make-point x y) (cons x y))

(define (x-point point) (car point))

(define (y-point point) (cdr point))

; one possible representation
(define (make-ret upper-left-point width height)
  (cons upper-left-point (cons width height)))

(define (width ret)
  (car (cdr ret)))

(define (height ret)
  (cdr (cdr ret)))

; another possible representation
;(define (make-ret upper-left-point lower-right-point)
;  (cons upper-left-point lower-right-point))
;
;(define (width ret)
;  (- (x-point (cdr ret))
;     (x-point (car ret))))
;
;(define (height ret)
;  (- (y-point (car ret))
;     (y-point (cdr ret))))

; wishful thinking
(define (perimeter ret)
  (* (+ (width ret)
        (height ret))
     2))

(define (area ret)
  (* (width ret)
     (height ret)))
