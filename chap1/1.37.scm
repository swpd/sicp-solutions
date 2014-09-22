; a.
(define (cont-frac n d k)
  (define (iter cur)
    (if (= cur k)
      (/ (n cur) (d cur))
      (/ (n cur) (+ (d cur) (iter (+ cur 1))))))
  (iter 1))


(define (k-term-cont-frac k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
             k))

; Find smallest k that gets an approximation with accuracy of 0.0001, which is 11.
(define (find-k k cur)
  (let ((accuracy 0.0001)
        (next (k-term-cont-frac (+ k 1))))
    (if (< (abs (- cur next)) accuracy)
      (+ k 1)
      (find-k (+ k 1) next))))

(find-k 1 (k-term-cont-frac 1))     ;Value: 11

; b.
(define (cont-frac-iter n d k)
  (define (iter cur result)
    (if (= cur 0)
      result
      (iter (- cur 1) (/ (n cur) (+ (d cur) result)))))
  (iter k 0))
