(define (expmod base exp m)
  (define (nontrivial? x)
    (if (and (not (= x 1))
              (not (= x (- m 1)))
              (= (remainder (square x) m) 1))
      0
      x)
    )
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (nontrivial? (expmod base (/ exp 2) m)))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else false)))

(fast-prime? 2 10)          ;Value: #t
(fast-prime? 3 10)          ;Value: #t
(fast-prime? 5 10)          ;Value: #t
(fast-prime? 7 10)          ;Value: #t
(fast-prime? 11 10)         ;Value: #t
(fast-prime? 13 10)         ;Value: #t
(fast-prime? 17 10)         ;Value: #t
(fast-prime? 19 10)         ;Value: #t


(fast-prime? 561 10)        ;Value: #f
(fast-prime? 1105 10)       ;Value: #f
(fast-prime? 1729 10)       ;Value: #f
(fast-prime? 2465 10)       ;Value: #f
(fast-prime? 2821 10)       ;Value: #f
(fast-prime? 6601 10)       ;Value: #f
