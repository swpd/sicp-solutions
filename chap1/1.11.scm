; recursive process
(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1))
                 (* 2 (f (- n 2)))
                 (* 3 (f (- n 3)))))))

; iterative process
(define (f2 n)
  (define (f-iter a b c n)
    (if (= n 0)
      a
      (f-iter b c (+ (* 3 a) (* 2 b) c) (- n 1))))
  (f-iter 0 1 2 n))
