#lang sicp

(define (square a) (* a a))

(define (sum_of_squares a b) (+ (square a) (square b)))

(define (sum_largest_two a b c)
  (cond ((and (>= a c) (>= b c)) (sum_of_squares a b))
        ((and (>= a b) (>= c b)) (sum_of_squares a c))
        (else (sum_of_squares b c))))




(sum_largest_two 1 2 3)
(sum_largest_two 5 1 4)
