(define nil (list))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define empty-board nil)

(define (safe? k positions)
  (if (<= k 1)
    #t
    (and (safe? (- k 1) positions)
         (accumulate
           (lambda (x y) (and x y))
           #t
           (map (lambda (x)
                  (not (or (= (cdr x) (cdar positions))
                           (= (abs (- (car x) (caar positions)))
                              (abs (- (cdr x) (cdar positions)))))))
                       (cdr positions))))))

(define (adjoin-position new-row k rest-of-queens)
  (cons (cons k new-row) rest-of-queens))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
