; Given two intervals
; `x = [w1 - w1 * p1, w1 + w1 * p1], y = [w2 - w2 * p2, w2 + w2 * p2]'.
; Then `x * y = [(w1 - w1 * p1) * (w2 - w2 * p2), (w1 + w1 * p1) * (w2 + w2 * p2)
;             = [(w1 * w2 * (1 - (p1 + p2) + p1 * p2)), (w1 * w2 * (1 + (p1 + p2) + p1 * p2)]'  (1)
; As `p1' and `p2' are small percentage tolerances, `p1 * p2' in (1) can be ignored.
; Thus `x * y' can be approximated as `[w1 * w2 - (p1 + p2) * w1 * w2, w1 * w2 + (p1 + p2) * w1 * w2]',
; which is an interval with center `w1 * w2' and percentage tolerance `p1 + p2'.

(define (make-interval a b) (cons a b))

(define (upper-bound i)
  (max (car i)
       (cdr i)))

(define (lower-bound i)
  (min (car i)
       (cdr i)))

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

(define (mul-interval x y)
  (make-center-percent (* (width x) (width y))
                       (+ (percent x) (percent y))))
