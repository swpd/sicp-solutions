(define (cons x y)
  (* (expt 2 x)
     (expt 3 y)))

(define (extract z factor)
  (if (= (remainder z factor) 0)
    (+ 1 (extract (/ z factor) factor))
    0))

(define (car z) (extract z 2))

(define (cdr z) (extract z 3))
