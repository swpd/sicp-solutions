; The following procedure returns the sum of `a' and absolute value of `b'.
; The `if' expression returns procedure `+' if `b' is larger than 0, or `-' otherwise.
; Then the returned procedure is applied on `a' and `b' to produce the final result `(a + |b|)'.

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
