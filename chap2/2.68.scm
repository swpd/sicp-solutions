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

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define sample-message '(a d a b b c a))

(encode sample-message sample-tree)     ;Value: (0 1 1 0 0 1 0 1 0 1 1 1 0)
