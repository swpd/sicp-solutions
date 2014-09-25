(define (cons x y)
  (lambda (m) (m x y)))

;(car (cons x y))
;(car (lambda (m) (m x y)))
;((lambda (m) (m x y)) (lambda (p q) p))
;((lambda (p q) p) x y)
;x
(define (car z)
  (z (lambda (p q) p)))

;(cdr (cons x y))
;(cdr (lambda (m) (m x y)))
;((lambda (m) (m x y)) (lambda (p q) q))
;((lambda (p q) q) x y)
;y
(define (cdr z)
  (z (lambda (p q) q)))
