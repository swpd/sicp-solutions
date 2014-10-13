; non-duplicate: O(n)
; duplicate: O(n)
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

; non-duplicate: O(n)
; duplicate: O(1)
(define (adjoin-set x set) (cons x set))

; non-duplicate: O(n^2)
; duplicate: O(n)
(define (union-set set1 set2) (append set1 set2))

; non-duplicate: O(n^2)
; duplicate: O(n^2)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; As from above, by using the non-duplicate representation of sets, `adjoin-set'
; and `union-set' no longer need to check for duplications. The order of growth
; of `adjoin-set' and `union-set' have been reduced to `O(1)' and `O(n)',
; respectively.
;
; Sets using duplicate representation require more storage than non-duplicate
; ones, and will slow down procedures that iterate through the whole set by some
; constant factor.
;
; Thus, we would probably only want to use duplicate representation for
; applications which are insensitive to memory overhead and involve a great
; number of calls to either `adjoin-set' or `union-set'.
