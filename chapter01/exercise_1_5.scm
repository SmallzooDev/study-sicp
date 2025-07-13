#lang sicp

(define (p) (p))
(define (test x y) (if (= x 0) 0 y))

(test 0 (p))

; on normal
; (if (= 0 0) 0 (p)) 여기서 더이상 전개하지 않음ret 0
; on applicative
; (if (= 0 0) 0 (p)) 여기서 p를 치환해서 넣으려다 무한루프

