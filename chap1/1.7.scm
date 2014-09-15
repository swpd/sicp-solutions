; When finding the square roots of very small numbers, the calculation might
; finish too early due to the relatively large precision, which will lead to
; inaccurate result.
; While for very large numbers, it might take long or forever for the calculation
; to finish because of the relatively samll precision is hard or unable to reach.
; (Due to the limited precision of real computers)

; The new `good-enough?' procedure that implementing the alternative strategy is
; defined as follows:

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess (improve guess x))
      (improve guess x)
      (sqrt-iter (improve guess x)
                 x)))

(define (good-enough? old-guess new-guess)
  (< (/ (abs (- old-guess new-guess))
        old-guess)
     0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))
