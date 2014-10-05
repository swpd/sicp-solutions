; By interchanging the order of the nested mappings, we're transforming a linear
; recursive process to a tree-recursive process.
; A tree-recursive process grows exponentially. If it takes time `T' to execute
; the origin version, it will take Louis's program roughly `T ^ n (n is the size
; of the board)' to achieve the same.
(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))
