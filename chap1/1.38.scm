(define (cont-frac-iter n d k)
  (define (iter cur result)
    (if (= cur 0)
      result
      (iter (- cur 1) (/ (n cur) (+ (d cur) result)))))
  (iter k 0))

(define (e k)
  (cont-frac-iter (lambda (i) 1.0)
                  (lambda (i)
                    (if (= (remainder i 3) 2)
                      (/ (* 2 (+ i 1)) 3)
                      1.0))
                  k))

(e 100)     ;Value: .7182818284590453
