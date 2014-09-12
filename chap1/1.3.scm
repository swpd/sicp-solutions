(define (square x) (* x x))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (sum-of-two-larger-squares x y z)
  (cond ((> x y) (sum-of-squares x (max y z)))
        (else (sum-of-squares y (max x z)))))
