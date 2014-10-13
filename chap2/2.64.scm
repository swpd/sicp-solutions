(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; a.
; `partial-tree' divides the input list into 3 parts: the median `this-entry',
; a sublist with elements less than median, and a sublist with elements greater
; than median.
; For each of the sublist, `partial-tree' is recursively applied to generated
; a balanced binary subtree.
; Then the subtrees are combined together with median as root to get the final
; result.

; The tree produced by `list->tree' for the list `(1 3 5 7 9 11)':

;        5
;      /   \
;     1     9
;      \   / \
;       3 7  11

; b.
; The procedure visits each element of the list once, and for each element
; constant-factor number of steps is required, thus the overall order of growth
; of `list->tree' is `O(n)'.
