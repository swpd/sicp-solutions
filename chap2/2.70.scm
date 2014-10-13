(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))

(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (has-symbol? symbol tree)
  (not (equal? #f (memq symbol (symbols tree)))))

(define (encode-symbol message tree)
  (if (has-symbol? message tree)
    (let ((left (left-branch tree))
          (right (right-branch tree)))
      (if (has-symbol? message left)
        (if (leaf? left)
          '(0)
          (cons 0 (encode-symbol message left)))
        (if (leaf? right)
          '(1)
          (cons 1 (encode-symbol message right)))))
    (error "bad symbol -- ENCODE-SYMBOL" message)))

(define (successive-merge pairs)
  (cond ((null? pairs) '())
        ((null? (cdr pairs)) (car pairs))
        (else (successive-merge (adjoin-set (make-code-tree (car pairs)
                                                            (cadr pairs))
                                            (cddr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define tree (generate-huffman-tree
               '((A 2) (NA 16) (BOOM 1) (SHA 3)
                       (GET 2) (YIP 9) (JOB 2) (WAH 1))))

(define msg-1 (encode '(Get a job) tree))
;Value: (1 1 1 1 1 1 1 0 0 1 1 1 1 0)

(define msg-2 (encode '(Sha na na na na na na na na) tree))
;Value: (1 1 1 0 0 0 0 0 0 0 0 0)

(define msg-3 (encode '(Wah yip yip yip yip yip yip yip yip yip) tree))
;Value: (1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0)

(define msg-4 (encode '(Sha boom) tree))
;Value: (1 1 1 0 1 1 0 1 1)

; Bits required for huffman encoding:
(+ (* 2 (length msg-1))
   (* 2 (length msg-2))
   (length msg-3)
   (length msg-4))                      ;Value: 84

; Bits required for fixed-length encoding (3 bit for each symbol):
(* 3
   (+ (* 2 (length '(Get a job)))
      (* 2 (length '(Sha na na na na na na na na)))
      (length '(Wah yip yip yip yip yip yip yip yip yip))
      (length '(Sha boom))))            ;Value: 108
