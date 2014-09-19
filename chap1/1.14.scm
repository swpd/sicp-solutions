; Tree-recursive process generated in computing `(count-change 11)'
;
; (count-change 11)
;         |
;     (cc 11 5) -- (cc -39 5) -- 0
;         |
;     (cc 11 4) -- (cc -14 4) -- 0
;         |
;     (cc 11 3) -- (cc 1 3) -- (cc -9 3) -- 0
;         |            |
;         |        (cc 1 2) -- (cc -4 2) -- 0
;         |            |
;         |        (cc 1 1) -- (cc 0 1) --  1
;         |            |
;         |        (cc 1 0)
;         |            |
;         |            0
;         |
;     (cc 11 2) -- (cc 6 2) -- (cc 1 2) -- (cc -4 2) -- 0
;         |            |           |
;         |            |       (cc 1 1) -- (cc 0 1) -- 1
;         |            |           |
;         |            |       (cc 1 0)
;         |            |           |
;         |            |           0
;         |            |
;         |        (cc 6 1) -- (cc 5 1) -- (cc 4 1) -- (cc 3 1) -- (cc 2 1) -- (cc 1 1) -- (cc 0 1) -- 1
;         |            |           |           |           |           |           |
;         |            |           |           |           |           |       (cc 1 0)
;         |            |           |           |           |           |           |
;         |            |           |           |           |           |           0
;         |            |           |           |           |           |
;         |            |           |           |           |       (cc 2 0)
;         |            |           |           |           |           |
;         |            |           |           |           |           0
;         |            |           |           |           |
;         |            |           |           |       (cc 3 0)
;         |            |           |           |           |
;         |            |           |           |           0
;         |            |           |           |
;         |            |           |       (cc 4 0)
;         |            |           |           |
;         |            |           |           0
;         |            |           |
;         |            |       (cc 5 0)
;         |            |           |
;         |            |           0
;         |            |
;         |        (cc 6 0)
;         |            |
;         |            0
;         |
;     (cc 11 1) -- (cc 10 1) -- (cc 9 1) -- (cc 8 1) -- (cc 7 1) -- (cc 6 1) -- (cc 5 1) -- (cc 4 1) -- (cc 3 1) -- (cc 2 1) -- (cc 1 1) -- (cc 0 1) -- 1
;         |            |            |           |           |           |           |           |           |           |           |
;         |            |            |           |           |           |           |           |           |           |       (cc 1 0)
;         |            |            |           |           |           |           |           |           |           |           |
;         |            |            |           |           |           |           |           |           |           |           0
;         |            |            |           |           |           |           |           |           |           |
;         |            |            |           |           |           |           |           |           |       (cc 2 0)
;         |            |            |           |           |           |           |           |           |           |
;         |            |            |           |           |           |           |           |           |           0
;         |            |            |           |           |           |           |           |           |
;         |            |            |           |           |           |           |           |       (cc 3 0)
;         |            |            |           |           |           |           |           |           |
;         |            |            |           |           |           |           |           |           0
;         |            |            |           |           |           |           |           |
;         |            |            |           |           |           |           |       (cc 4 0)
;         |            |            |           |           |           |           |           |
;         |            |            |           |           |           |           |           0
;         |            |            |           |           |           |           |
;         |            |            |           |           |           |       (cc 5 0)
;         |            |            |           |           |           |           |
;         |            |            |           |           |           |           0
;         |            |            |           |           |           |
;         |            |            |           |           |       (cc 6 0)
;         |            |            |           |           |           |
;         |            |            |           |           |           0
;         |            |            |           |           |
;         |            |            |           |       (cc 7 0)
;         |            |            |           |           |
;         |            |            |           |           0
;         |            |            |           |
;         |            |            |       (cc 8 0)
;         |            |            |           |
;         |            |            |           0
;         |            |            |
;         |            |        (cc 9 0)
;         |            |            |
;         |            |            0
;         |            |
;         |        (cc 10 0)
;         |            |
;         |            0
;         |
;     (cc 11 0)
;         |
;         0
;
; The order of growth of the space is `O(n)' because the depth of the tree grows
; linearly with amount `n'.
;
; The order of growth of the number of steps is `O(n^m)', where `m' indicates the
; number of denominations of coins.
; As from the graph above, the right branch is called `O(n)' times and each time
; the left branch takes the steps required by `n' with `m - 1' kind of coins.
; For `m = 1', we can easily figure out that the order of growth of time is `O(n)';
; For `m > 1', the order of growth of time is `O(n * n * n * n...) = O(n^m)'.

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 11)   ;Value: 4
