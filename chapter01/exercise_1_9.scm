#lang sicp

(define (plus a b)
  (if (= a 0) b (inc (plus (dec a) b))))

(define (plus a b)
  (if (= a 0) b (plus (dec a) (inc b))))

; case 1 : inc를 하는 시점에 (dec a) b 를 plus한 결과를 평가하기 위해서 재귀 발생
; case 2 : (dec a) (inc b)의 평가가 끝난 상태로 plus가 호출됨으로 iterative
 
; case 1: (plus 4 5)
; (if (= 4 0) 5 (inc (plus (dec 4) 5)))
; (inc (plus (dec 4) 5))
; (inc (+ 3 5))
; (inc (if (= 3 0) 5 (inc (plus (dec 3) 5))))
; (inc (inc (plus (dec 3) 5)))
; (inc (inc (plus 2 5)))
; (inc (inc (if (= 2 0) 5 (inc (plus (dec 2) 5)))))
; (inc (inc (inc (plus (dec 2) 5))))
; (inc (inc (inc (plus 1 5))))
; (inc (inc (inc (if (= 1 0) 5 (inc (plus (dec 1) 5))))))
; (inc (inc (inc (inc (plus (0 5))))))
; (inc (inc (inc (inc (if (= 0 0) 5 (inc (plus (dec 0) 5)))))))
; (inc (inc (inc (inc 5))))
; ...
; (inc 8)
; 9

; case 2: (+ 4 5)
; (if (= 4 0) 5 (+ (dec 4) (inc 5)))
; (+ (dec 4) (inc 5))
; (+ 3 6)
; (if (= 3 0) 6 (+ (dec 3) (inc 6)))
; (+ (dec 3) (inc 6))
; (+ 2 7)
; (if (= 2 0) 7 (+ (dec 2) (inc 7)))
; (+ (dec 2) (inc 7))
; (+ 1 8)
; (if (= 1 0) 8 (+ (dec 1) (inc 8)))
; (+ (dec 1) (inc 8))
; (+ 0 9)
; (if (= 0 0) 9 (+ (dec 0) (inc 9)))
; 9 

