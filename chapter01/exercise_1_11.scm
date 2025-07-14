#lang sicp

(define (recursive n)
  (cond ((< n 3) n)
        (else (+ (recursive (- n 1))
                 (* 2 (recursive (- n 2)))
                 (* 3 (recursive (- n 3)))))))

(define (iter n)
  (if (< n 3)
      n
      (iter-helper 2 1 0 (- n 2))))  ; f(2), f(1), f(0)부터 시작

(define (iter-helper a b c count)
  (if (= count 0)
      a                              ; 현재 a가 우리가 원하는 값
      (iter-helper (+ a (* 2 b) (* 3 c))  ; 새로운 f(n)
                   a                      ; 이전 a가 새로운 b
                   b                      ; 이전 b가 새로운 c  
                   (- count 1))))
