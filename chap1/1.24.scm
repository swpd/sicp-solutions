(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m)))) 

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (prime? n)
  (fast-prime? n 10))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start count)
  (define (search-iter cur count)
    (if (and (> count 0) (prime? cur)) (timed-prime-test cur))
    (if (> count 0) (search-iter (+ cur 2)
                                 (if (prime? cur)
                                   (- count 1)
                                   count))))
  (search-iter (if (even? start)
                 (+ start 1)
                 start) count))

(search-for-primes 1000000000 3)
;Old Result:
;1000000007 *** 3.9999999999999994e-2
;1000000009 *** .04000000000000001
;1000000021 *** .03999999999999998
;
;New Result:
;1000000007 *** 0.
;1000000009 *** 0.
;1000000021 *** 0.

(search-for-primes 10000000000 3)
;Old Result:
;10000000019 *** .12
;10000000033 *** .1200000000000001
;10000000061 *** .11999999999999988
;
;New Result:
;10000000019 *** 0.
;10000000033 *** 0.
;10000000061 *** 0.

(search-for-primes 100000000000 3)
;Old Result:
;100000000003 *** .3800000000000001
;100000000019 *** .3700000000000001
;100000000057 *** .3799999999999999
;
;New Result:
;100000000003 *** 0.
;100000000019 *** 0.
;100000000057 *** 0.

(search-for-primes 1000000000000 3)
;Old Result:
;1000000000039 *** 1.17
;1000000000061 *** 1.1799999999999997
;1000000000063 *** 1.1899999999999995
;
;New Result:
;1000000000039 *** 0.
;1000000000061 *** 0.
;1000000000063 *** 0.

; As from the previous results, `fermat-test' is much more fast and it is hard to
; obtain reasonable results.
; The following tests find the three smallest primes larger than 1e24, 1e48, 1e96,
; respectively. We can see that testing a number with twice as many digits is
; not strictly `2' but roughly `4' times slower.
; This may related to the extra `cond' test in the procedure `fast-prime?'.

(search-for-primes 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 3)
;Result:
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000127 *** 9.999999999999981e-3
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000837 *** 1.0000000000000009e-2
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001107 *** 1.0000000000000009e-2

(search-for-primes 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 3)
;Result:
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001153 *** 4.0000000000000036e-2
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001669 *** 4.0000000000000036e-2
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002173 *** .03999999999999915

(search-for-primes 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 3)
;Result:
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000171 *** .16000000000000014
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001227 *** .16000000000000014
;1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001347 *** .1600000000000037