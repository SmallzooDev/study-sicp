#lang sicp

(define (improve guess x)
  (/ (+ (/ x (square guess))
     (* 2 guess))
      3))

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (good-enough? guess previous-guess)
  (< (abs (- guess previous-guess))
     (* guess 0.001)))

(define (cbrt-iter guess previous-guess x)
  (if (good-enough? guess previous-guess)
      guess
      (cbrt-iter (improve guess x)
                 guess
                 x)))

(define (cbrt x)
  (cbrt-iter 1.0 0.0 x))

(cbrt 27)
