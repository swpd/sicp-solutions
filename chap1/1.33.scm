(define (filtered-accumulate predicate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a)
            (if (predicate a)
              (combiner result (term a))
              result))))
  (iter a null-value))

; a.
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

(define (prime? n)
  (fast-prime? n 10))

(define (inc n) (+ n 1))

(define (sum-prime-squares a b)
  (filtered-accumulate prime? + 0 square a inc b))

; b.
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (identity n) n)

(define (product-relatively-prime n)
  (define (relatively-prime? x)
    (= (gcd n x) 1))
  (filtered-accumulate relatively-prime? * 1 identity 1 inc n))
