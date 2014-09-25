; Given two interval `x = [a, b], y = [c, d]' respectively.
; Let `w(x)' be the function that calculates the width of an interval.
; We have `w(x) = (b - a) / 2, w(y) = (d - c) / 2'.
;
; addition:
;   `w(z) = w(x + y) = w([a + c, b + d]) = ((b + d) - (a + c)) / 2
;         = (b - a) / 2 + (d - c) / 2 = w(x) + w(y)'
;
; subtraction:
;   `w(z) = w(x - y) = w([a - c, b - d]) = ((b - d) - (a - c)) / 2
;         = (b - a) / 2 - (d - c) / 2 = w(x) - w(y)'
;
; Thus the width of the sum (or differences) of two intervals is a function only
; of the widths of the intervals being added (or subtracted).
;
; A counter example:
; Suppose `x1 = [1, 2], y1 = [3, 4]; x2 = [2, 3], y2 = [4, 5]'.
; Then `w(x1) = w(y1) = w(x2) = w(y2) = 1'.
;
; multiplication:
;   `w(x1 * y1) = w([3, 8]) = 5' while `w(x2 * y2) = w([8, 15]) = 7'
;
; division:
;   `w(x1 / y1) = w([1/4, 2/3]) = 5/12' while `w(x2 / y2) = w([2/5, 3/4]) = 7/20'
;
; Thus the width of the multiplication (or division) of two intervals isn't a
; function of the widths of the intervals being multiplied (or divided).
