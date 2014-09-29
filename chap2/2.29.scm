(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a.
(define (left-branch mobile) (car mobile))

(define (right-branch mobile) (cadr mobile))

(define (branch-length branch) (car branch))

(define (branch-structure branch) (cadr branch))

; b.
(define (is-mobile? branch)
  (pair? (branch-structure branch)))

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (if (is-mobile? branch)
      (total-weight structure)
      structure)))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; c.
(define (torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (branch-balanced? branch)
  (if (is-mobile? branch)
    (mobile-balanced? (branch-structure branch))
    #t))

(branch-balanced? (make-branch 10 10))

(define (mobile-balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (and (branch-balanced? left)
         (branch-balanced? right)
         (= (torque left) (torque right)))))

; d.
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

; We only need to change the corresponding selectors:
(define (right-branch mobile) (cdr mobile))

(define (branch-structure branch) (cdr branch))
