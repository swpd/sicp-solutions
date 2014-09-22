; Alyssa's solution is correct but is much slower than the original one.
; The modified version of procedure `expmod' will generate huge intermediate
; results which will make it considerably longer to get the same final result.

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))
