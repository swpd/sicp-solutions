(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpsom-rule f a b n)
  (define h (/ (- b a) n))
  (define (simpsom-term k)
    (* (cond ((or (= k 0) (= k n)) 1)
             ((even? k) 2)
             (else 4))
       (f (+ a (* k h)))))
  (define (simpsom-next k)
    (+ k 1))
  (* (sum simpsom-term 0 simpsom-next n) (/ h 3)))

(define (cube x) (* x x x))

(simpsom-rule cube 0 1 100)     ;Value: 1/4
(simpsom-rule cube 0 1 1000)    ;Value: 1/4
