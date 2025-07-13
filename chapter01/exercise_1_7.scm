#lang sicp
; 문제를 이해못했는데 부동소수점 정밀도 때문에 무한루프에 빠지는 상황을 개선해야하는 문제였다고한다.


; former
(define (former-good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

; improved
(define (good-enough? guess previous-guess)
  (< (abs (- guess previous-guess)) 
     (* guess 0.001)))

(define (sqrt-iter guess previous-guess x)
  (if (good-enough? guess previous-guess)
      guess
      (sqrt-iter (improve guess x) 
                 guess 
                 x)))

(define (sqrt x)
  (sqrt-iter 1.0 0.0 x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

