(define (reverse items)
  (if (null? items)
    items
    (cons (reverse (cdr items)) (car items))))

(reverse (list 1 4 9 16 25))    ;Value: (25 16 9 4 1)
