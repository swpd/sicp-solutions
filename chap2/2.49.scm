(define (make-vect x y) (cons x y))

(define (xcor-vect v) (car v))

(define (ycor-vect v) (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v))
             (* s (ycor-vect v))))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame) (car frame))

(define (edge1-frame frame) (cadr frame))

(define (edge2-frame frame) (cddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (make-segment start-vec end-vec) (cons start-vec end-vec))

(define (start-segment segment) (car segment))

(define (end-segment segment) (cdr segment))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

; a.
(define top-left (make-vec 0 1))

(define top-right (make-vec 1 1))

(define bottom-left (make-vec 0 0))

(define bottom-right (make-vec 1 0))

(define outline-painter (segments->painter
                          (list (make-segment top-left top-right)
                                (make-segment top-right bottom-right)
                                (make-segment bottom-right bottom-left)
                                (make-segment bottom-left top-left))))

; b.
(define x-painter (segments->painter
                    (list (make-segment top-left bottom-right)
                          (make-segment top-right bottom-left))))

; c.
(define top-mid (make-vec 0.5 1))

(define bottom-mid (make-vec 0.5 0))

(define left-mid (make-vec 0 0.5))

(define right-mid (make-vec 1 0.5))

(define diamond-painter (segments->painter
                          (list (make-segment top-mid left-mid)
                                (make-segment left-mid bottom-mid)
                                (make-segment bottom-mid right-mid)
                                (make-segment right-mid top-mid))))

; d.
(define wave-painter (segments->painter
                       (list (make-vect 0.4  0.0)
                             (make-vect 0.5  0.33)
                             (make-vect 0.6  0.0)
                             (make-vect 0.25 0.0)
                             (make-vect 0.33 0.5)
                             (make-vect 0.3  0.6)
                             (make-vect 0.1  0.4)
                             (make-vect 0.0  0.6)
                             (make-vect 0.0  0.8)
                             (make-vect 0.1  0.6)
                             (make-vect 0.33 0.65)
                             (make-vect 0.4  0.65)
                             (make-vect 0.35 0.8)
                             (make-vect 0.4  1.0)
                             (make-vect 0.75 0.0)
                             (make-vect 0.6  0.45)
                             (make-vect 1.0  0.15)
                             (make-vect 1.0  0.35)
                             (make-vect 0.8  0.65)
                             (make-vect 0.6  0.65)
                             (make-vect 0.65 0.8)
                             (make-vect 0.6  1.0))))
