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

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (sub-vect (m corner1) new-origin)
                     (sub-vect (m corner2) new-origin)))))))

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (below painter1 painter2)
  (let ((split-point (make-vec 0.0 0.5)))
    (let ((paint-up
           (transform-painter painter2
                              split-point
                              (make-vec 1.0 0.5)
                              (make-vec 0.0 1.0)))
         (paint-down
           (transform-painter painter1
                              (make-vec 0.0 0.0)
                              (make-vec 1.0 0.0)
                              split-point)))
      (lambda (frame)
        (paint-up frame)
        (paint-down frame)))))

; a.
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
                             (make-vect 0.6  1.0)
                             ; newly added smile
                             (make-vect 0.45 0.75)
                             (make-vect 0.5  0.7)
                             (make-vect 0.55 0.75))))

; b.
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
    painter
    (let ((smaller (up-split painter (- n 1))))
      (below painter (beside smaller smaller)))))

(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1)))
            (corner (corner-split painter (- n 1))))
        (beside (below painter up)
                (below right corner)))))

; c.
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside (tl painter) (tr painter)))
          (bottom (beside (bl painter) (br painter))))
      (below bottom top))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (flip-horiz painter)
  (transform-painter painter
                     (make-vec 1.0 0.0)
                     (make-vec 0.0 0.0)
                     (make-vec 1.0 1.0)))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vec 1.0 1.0)
                     (make-vec 0.0 1.0)
                     (make-vec 1.0 0.0)))

(define (identity x) x)

(define (square-limit painter n)
  (let ((combine4 (square-of-four identity flip-horiz
                                  filp-vert rotate180))))
  (combine4 (corner-split painter n)))
