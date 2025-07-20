#lang sicp

(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))
                   (+ (* 2 p q) (* q q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b q) (* a p))
                        p
                        q
                        (- count 1)))
        ))
; a1 <- bq + aq + ap
; b1 <- bp + aq

; a2 <- b1q + a1q + a1p
; b2 <- b1p + a1q

; a2 = b1q + a1q + a1p
;    = b1q + a1(q + p)
;    = (bp + aq)q + (bq + aq + ap)(q + p)
; ...
;    = b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2)
