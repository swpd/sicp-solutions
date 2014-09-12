; Procedure `p' is recursively defined by itself, thus when `p' is called the
; interpreter will enter an infinite loop.
;
; If an interpreter uses applicative-order, it will first evaluates operands of
; a given procedure before applying. That means `p' will be evaluated in the
; following example, which will result in an infinite loop of the interpreter.
;
; If an interpreter uses normal-order, the operands of a given procedure would
; not be evaluated util their values were needed. When evaluating the `if'
; expression, the `<predicate>' part `(= x 0)' returns `#t', causing it to return
; `0' and skip the evaluation of `p'. Thus the interpreter will simply print `0'.

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))
