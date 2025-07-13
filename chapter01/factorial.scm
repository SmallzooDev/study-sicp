#lang sicp

(define (factorial-recur n)
  (if (=n 1)
    1
    (* n (factorial-recur (- n 1)))))


(define (factirial-iter n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

; fact-iter (1 1 6)
; fact-iter (1 2 6)
; fact-iter (2 3 6)
; fact-iter (6 4 6)
