(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (lookup given-key set-of-records)
  (if (null? set-of-records)
    #f
    (let ((root (entry set-of-records)))
      (cond ((= given-key (key root)) root)
            ((< given-key (key root)) (lookup given-key
                                              (left-branch set-of-records)))
            ((> given-key (key root)) (lookup given-key
                                              (right-branch set-of-records)))))))
