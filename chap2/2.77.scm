; (magnitude z)
; (magnitude (make-from-real-img 3 4))
; (magnitude ((get 'make-from-real-img 'complex) 3 4))
; (magnitude (tag (make-from-real-img 3 4)))
; (magnitude (attach-tag 'complex (make-from-real-img 3 4)))
; (magnitude (cons 'complex (make-from-real-img 3 4)))
; (magnitude (cons 'complex ((get 'make-from-real-img 'rectangular) 3 4)))
; (magnitude (cons 'complex (tag (make-from-real-img 3 4))))
; (magnitude (cons 'complex (attach-tag 'rectangular (make-from-real-img 3 4))))
; (magnitude (cons 'complex (cons 'rectangular (cons 3 4))))
; (magnitude '(complex rectangular 3 4))
; (apply-generic 'magnitude '(complex rectangular 3 4))
; (magnitude '(rectangular 3 4))
; (apply-generic 'magnitude '(rectangular 3 4))
; (magnitude '(3 4))
; (sqrt (+ (square (real-part '(3 4))))
;       (+ (square (imag-part '(3 4)))))
; 5

; `apply-generic' is applied twice, the first procedure dispatched is `magnitude'
; of `complex' package and the second one is `magnitude' of `rectangular' package.
