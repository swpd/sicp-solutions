(define (iterative-improve good-enough? improve)
  (define (iter guess)
    (if (good-enough? guess)
      guess
      (iter (improve guess))))
  (lambda (x) (iter x)))

(define (sqrt x)
  (define (good-enough? guess)
    (let ((tolerance 0.001))
      (< (abs (- (square guess) x)) tolerance)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (improve guess)
    (average guess (/ x guess)))
  ((iterative-improve good-enough? improve) 1.0))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (let ((tolerance 0.00001))
      (< (abs (- v1 v2)) tolerance)))
  (define (good-enough? guess)
    (close-enough? guess (improve guess)))
  (define (improve guess)
    (f guess))
  ((iterative-improve good-enough? improve) first-guess))