(define nil (list))

(fold-right / 1 (list 1 2 3))           ;Value: 3/2
(fold-left / 1 (list 1 2 3))            ;Value: 1/6
(fold-right list nil (list 1 2 3))      ;Value: (1 (2 (3 ())))
(fold-left list nil (list 1 2 3))       ;Value: (((() 1) 2) 3)

; The property that `op' should satisfy to guarantee that `fold-right' and
; `fold-left' will produce the same values for any sequence is commutativity.
