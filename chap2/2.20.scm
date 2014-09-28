(define (same-parity head . tail)
  (define (iter items)
    (if (null? items)
      items
      (if (even? (+ head (car items)))
        (cons (car items)
              (iter (cdr items)))
        (iter (cdr items)))))
  (cons head (iter tail)))

(same-parity 1 2 3 4 5 6 7)     ;Value: (1 3 5 7)

(same-parity 2 3 4 5 6 7)       ;Value: (2 4 6)
