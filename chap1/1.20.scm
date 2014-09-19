; Normal order:
;
; (gcd 206 40)
; (gcd 40 (remainder 206 40))
; (if (= (remainder 206 40) 0)
;     40
;     (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))
; (gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
; (if (= (remainder 40 (remainder 206 40)) 0)
;     (remainder 206 40)
;     (gcd (remainder 40 (remainder 206 40))
;          (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; (gcd (remainder 40 (remainder 206 40))
;      (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
; (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0)
;     (remainder 40 (remainder 206 40))
;     (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;          (remainder (remainder 40 (remainder 206 40))
;                     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))))
; (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;      (remainder (remainder 40 (remainder 206 40))
;                 (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
; (if (= (remainder (remainder 40 (remainder 206 40))
;                   (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0)
;     (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;     (gcd (remainder (remainder 40 (remainder 206 40))
;                     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
;          (remainder (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;                     (remainder (remainder 40 (remainder 206 40))
;                                (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
; (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
; 2
;
; `remainder' is performed 18 times

; Applicative order:
;
; (gcd 206 40)
; (gcd 40 (remainder 206 40))
; (gcd 40 6)
; (gcd 6 (remainder 40 6))
; (gcd 6 4)
; (gcd 4 (remainder 6 4))
; (gcd 4 2)
; (gcd 2 (remainder 4 2))
; (gcd 2 0)
; 2
;
; `remainder' is performed 4 times

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(gcd 206 40)    ;Value: 2
