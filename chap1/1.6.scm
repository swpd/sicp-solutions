; As `new-if' is provided as an ordinary procedure, all of its operands are
; evaluated first within an applicative-order interpreter. Therefore, `sqrt-iter'
; in the `<else-cluase>' will be evaluated and this will lead to an infinite
; recursion. Besides, `sqrt-iter' isn't a tail recursive procedure, which will
; finally result in a stack overflow of the interpreter.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))
