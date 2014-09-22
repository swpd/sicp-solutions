(define (f g)
  (g 2))

(f square)

(f (lambda (z) (* z (+ z 1))))

(f f)
; (f f)
; (f 2)
; (2 2)
; The object 2 is not applicable.
;
; The second invocation of the procedure will apply `2' to `2', which is not
; applicable, causing the interpreter to throw an error.
