; procedure double
(define (double x) (+ x x))

; procedure halve
(define (halve x) (/ x 2))

(define (fast-multi a b)
  (define (fast-multi-iter a b product)
    (cond ((= b 0) product)
          ((even? b) (fast-multi-iter (double a) (halve b) product))
          (else (fast-multi-iter a (- b 1) (+ product a)))))
  (fast-multi-iter a b 0))
