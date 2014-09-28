(define (deep-reverse x)
  (if (or (null? x) (not (pair? x)))
    x
    (append (deep-reverse (cdr x))
            (list (deep-reverse (car x))))))

(define x (list (list 1 2) (list 3 4)))

(deep-reverse x)    ;Value: ((4 3) (2 1))
