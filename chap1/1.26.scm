; The modified version of procedure `expmod' generates a tree recursion, whose
; order of growth of time is exponential with height of the tree, which is
; `O(2^(log(n))) = O(n)'.

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
