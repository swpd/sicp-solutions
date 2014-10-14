(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

; a.
; The above procedure dispatches the operations according to the operator extracted
; from the expressions instead of checking the type of expressions inside `deriv'.
; This allows isolation of the procedure `deriv' and the operations it supports.
; We can't assimilate the predicates `number?' and `same-variable?' into the
; data-directed dispatch because it is impossible to extract operators from them.

; b.
(define (install-sum-package)
  ;; internal procedures
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))
  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  (put 'deriv '+ deriv-sum)
  'done)

(define (install-product-package)
  ;; internal procedures
  (define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))
  (define (deriv-product exp var)
    (make-sum
      (make-product (multiplier exp)
                    (deriv (multiplicand exp) var))
      (make-product (deriv (multiplier exp) var)
                    (multiplicand exp))))
  (put 'deriv '* deriv-product)
  'done)

; c.
(define (install-exponentiation-package)
  ;; internal procedures
  (define (make-exponentiation base exponent)
    (cond ((=number? exponent 0) 1)
          ((=number? exponent 1) base)
          (else (list '** base exponent))))
  (define (base e) (cadr e))
  (define (exponent e) (caddr e))
  (define (deriv-exponentiation exp var)
    (make-product (deriv (base exp) var)
                  (make-product (exponent exp)
                                (make-exponentiation (base exp)
                                                     (- (exponent exp) 1)))))
  (put 'deriv '** deriv-exponentiation)
  'done)

; d.
; We only need to alter the ordering of the parameters of the `put' statments.
(put '+ 'deriv deriv-sum)
(put '* 'deriv deriv-product)
(put '** 'deriv deriv-exponentiation)
