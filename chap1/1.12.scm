(define (pascal-tri row col)
  (cond ((or (= col 0) (= col row)) 1)
        (else (+ (pascal-tri (- row 1) (- col 1))
                 (pascal-tri (- row 1) col)))))
