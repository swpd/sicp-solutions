(define (make-interval a b) (cons a b))

(define (upper-bound i)
  (max (car i)
       (cdr i)))

(define (lower-bound i)
  (min (car i)
       (cdr i)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (sub-interval x y)
  (add-interval x
                (make-interval (- (lower-bound y))
                               (- (upper-bound y)))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (make-center-width c (* c p 0.01)))

(define (percent i)
  (* (/ (width i) (center i))
     100.0))

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define (print-center-percent i)
  (display (center i))
  (display " +- ")
  (display (percent i))
  (display "%"))

(define A (make-center-percent 100 5))

(define B (make-center-percent 200 5))

(print-center-percent (par1 A B))              ;Value: 67.33500417710944 +- 14.900744416873446%

(print-center-percent (par2 A B))              ;Value: 66.66666666666666 +- 5.000000000000004%

; As with above results, Lem is right.

(print-center-percent (div-interval A A))      ;Value: 1.0050125313283207 +- 9.97506234413964%

(print-center-percent (div-interval A B))      ;Value: .5025062656641603 +- 9.97506234413964%
