; a. We want to find the smallest natural number `n' such that `12 / 3^n <= 0.1',
; by solving the inequation we have `n = 5'. Thus procedure `p' will be applied
; 5 times when `(sine 12.15)' is evaluated.
;
; b. The order of growth in space and number of steps used by the process are
; both `log(a)'.

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))

(sine 12.15)    ;Value: -.39980345741334
