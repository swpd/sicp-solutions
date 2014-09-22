(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))    

(define (carmichael-num? n)
  (define (carmichael-num-iter cur)
    (cond ((= cur n) true)
          ((= (expmod cur n n) cur) (carmichael-num-iter (+ cur 1)))
          (else false)))
  (carmichael-num-iter 1))

(carmichael-num? 561)       ;Value: #t
(carmichael-num? 1105)      ;Value: #t
(carmichael-num? 1729)      ;Value: #t
(carmichael-num? 2465)      ;Value: #t
(carmichael-num? 2821)      ;Value: #t
(carmichael-num? 6601)      ;Value: #t
