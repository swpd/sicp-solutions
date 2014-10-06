(define (split outer-combine inner-combine)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller ((split (outer-combine innter-combine) painter (- n 1)))))
        (outer-combine painter (inner-combine smaller smaller))))))

(define right-split (split beside below))

(define up-split (split below beside))
