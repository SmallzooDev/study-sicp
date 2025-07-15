#lang sicp

(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))


; (sine 12.15) : 5번 호출 (p가)
; (p (p (p (p (p (sine 0.05))))))
;
; 시간복잡도 및 공간복잡도 : log3 n
