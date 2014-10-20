(define (apply-generic op . args)
  (define (can-coerce-list-to-type? type)
    (fold-left and
               #t
               (map (lambda (x)
                      (let ((typex (type-tag x)))
                        (if (equal? typex type)
                          #t
                          (let (t1->t2 (get-coercion typex type))
                            (if t1->t2
                              #t
                              #f)))))
                    args)))

  (define (apply-coercion lst)
    (if (null? lst)
      (error "No method for these types"
             (list op type-tags))
      (if (can-coerce-list-to-type? lst)
        (apply-generic op (map (lambda (x)
                                 (let ((typex (type-tag x)))
                                   (if (equal? typex type)
                                     x
                                     ((get-coercion typex type) x))))
                               (args)))
        (apply-coercion (cdr lst)))))

  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (apply-coercion args)))))

; Consider a mixed-type procedure `P' that takes two objects of type `A' and type
; `B', and we have type `C' which can be coerced to `B'.
; Besides, there are not procedures for coercing `A' to `C' nor `C' to `A'.
; If we pass two objects of type `A' and type `C' to `P', `apply-generic' will
; fail.
