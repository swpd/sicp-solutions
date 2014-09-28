; Because for each iteration the head of the remaining list is appended in front
; of the `answer', which results in a reverse answer list.
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

; Because the `cons' only build list when its first argument is an element and its
; second argument is a list. The following implemenation flips the arguments of
; `cons' and therefore doesn't work either.
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))
