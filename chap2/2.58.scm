(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (deriv (base exp) var)
                       (make-product (exponent exp)
                                     (make-exponentiation (base exp)
                                                          (- (exponent exp) 1)))))
        (else
         (error "unknown expression type -- DERIV" exp))))

; a.
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        (else (list base '** exponent))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p) (caddr p))

(define (exponentiation? x)
  (and (pair? x) (eq? (cadr x) '**)))

(define (base e) (car e))

(define (exponent e) (caddr e))

; b.
(define (operation? expr op)
  (fold-right (lambda (x y)
                (or y (eq? x op)))
              #f
              expr))

(define (prefix item x)
  (if (or (null? x)
          (eq? (car x) item))
    '()
    (cons (car x) (prefix item (cdr x)))))

(define (sum? x) (operation? x '+))

(define (addend s)
  (let ((a (prefix '+ s)))
    (if (null? (cdr a))
      (car a)
      a)))

(define (augend s)
  (let ((a (cdr (memq '+ s))))
    (if (null? (cdr a))
      (car a)
      a)))

(define (product? x) (operation? x '*))

(define (multiplier p)
  (let ((m (prefix '* p)))
    (if (null? (cdr m))
      (car m)
      m)))

(define (multiplicand p)
  (let ((m (cdr (memq '* p))))
    (if (null? (cdr m))
      (car m)
      m)))

(define (exponentiation? x) (operation? x '**))

(define (base e)
  (let ((b (prefix '** e)))
    (if (null? (cdr b))
      (car b)
      b)))

(define (exponent e)
  (let ((ex (cdr (memq '** e))))
    (if (null? (cdr ex))
      (car ex)
      ex)))
