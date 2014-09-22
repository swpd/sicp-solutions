(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (next n)
  (if (even? n)
    (+ n 1)
    (+ n 2)))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

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

; As from the results, the observed ratio is not exactly `2' but roughly `1.5'.
; This may related to the extra `if' test in the procedure `next'.

(search-for-primes 1000000000 3)
;Old Result:
;1000000007 *** 3.9999999999999994e-2
;1000000009 *** .04000000000000001
;1000000021 *** .03999999999999998
;
;New Result:
;1000000007 *** 2.0000000000000004e-2
;1000000009 *** .03
;1000000021 *** .03

(search-for-primes 10000000000 3)
;Old Result:
;10000000019 *** .12
;10000000033 *** .1200000000000001
;10000000061 *** .11999999999999988
;
;New Result:
;10000000019 *** .07999999999999996
;10000000033 *** .08999999999999997
;10000000061 *** .06999999999999995

(search-for-primes 100000000000 3)
;Old Result:
;100000000003 *** .3800000000000001
;100000000019 *** .3700000000000001
;100000000057 *** .3799999999999999
;
;New Result:
;100000000003 *** .30000000000000004
;100000000019 *** .25
;100000000057 *** .22999999999999998

(search-for-primes 1000000000000 3)
;Old Result:
;1000000000039 *** 1.17
;1000000000061 *** 1.1799999999999997
;1000000000063 *** 1.1899999999999995
;
;New Result:
;1000000000039 *** .7700000000000005
;1000000000061 *** .7700000000000005
;1000000000063 *** .7699999999999996
