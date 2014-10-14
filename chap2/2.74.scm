; a.
(define (get-record employee-name generic-file)
  ((get 'get-record (division generic-file)) employee-name
                                             (employee-file generic-file)))

; Each individual division's file should be structured in a more generic form by
; adding the division name in front of it.
(define (make-generic-file division employee-file)
  (cons division employee-file))

(define (division generic-file) (car generic-file))

(define (employee-file generic-file) (cdr generic-file))

; b.
(define (get-salary generic-record)
  ((get 'get-salary (division generic-record)) (employee-record generic-record)))

; Each individual record should be structured in a more generic form by adding
; the division name in front of it.
(define (make-generic-record division employee-record)
  (cons division employee-record))

(define (division generic-record) (car generic-record))

(define (employee-record generic-record) (cdr generic-record))

; c.
(define (find-employee-record employee-name generic-file-list)
  (if (null? generic-file-list)
    #f
    (or (get-record employee-name (car generic-file-list))
        (find-employee-record employee-name (cdr generic-file-list)))))

; d.
; Each new division needs to install its own `get-record' and `get-salary' generic
; procedures into the lookup table.
