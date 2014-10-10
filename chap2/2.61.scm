(define (adjoin-set x set)
  (if (null? set)
    (cons x set)
    (let ((head (car set)))
      (cond ((= head x) set)
            ((> head x) (cons x set))
            (else (cons head
                        (adjoin-set x (cdr set))))))))
