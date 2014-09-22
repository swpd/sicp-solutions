; a.
(define (product term a next b)
  (if (> a b)
    1
    (* (term a)
       (product term (next a) next b))))

(define (identity x) x)

(define (inc x) (+ x 1))

; factorial
(define (factorial n) (product identity 1 inc n))

; pi
(define (pi n)
  (define (pi-term x)
    (if (even? x)
      (/ (+ x 2) (+ x 1))
      (/ (+ x 1) (+ x 2))))
  (* 4 (product pi-term 1 inc n)))

; b.
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a)))))
  (iter a 1))
