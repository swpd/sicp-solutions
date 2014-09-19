; procedure double
(define (double x) (+ x x))

; procedure halve
(define (halve x) (/ x 2))

(define (fast-multi a b)
  (cond ((= b 0) 0)
        ((even? b) (double (fast-multi a (halve b))))
        (else (+ a (fast-multi a (- b 1))))))
