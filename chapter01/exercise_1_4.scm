#lang sicp

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; it works so a + |b| out

(a-plus-abs-b 3 -10)
