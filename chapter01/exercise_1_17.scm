#lang sicp

(define (mult a b)
  (mult-iter a b 0))

(define (mult-iter a b c)
  (cond
   ((= b 0) c)
   ((even? b) (mult-iter (double a) (halve b) c))  
   (else (mult-iter a (- b 1) (+ c a)))))
