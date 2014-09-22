(define (cont-frac-iter n d k)
  (define (iter cur result)
    (if (= cur 0)
      result
      (iter (- cur 1) (/ (n cur) (+ (d cur) result)))))
  (iter k 0))

(define (tan-cf x k)
  (cont-frac-iter (lambda (i)
                    (if (= i 1)
                      x
                      (- (square x))))
                  (lambda (i) (- (* 2 i) 1))
                  k))
