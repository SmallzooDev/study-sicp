#lang sicp
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

; (A 1 10)
; (A (- 1 1) (A 1 (- 10 1)))       
; (A 0 (A 1 9))
; (A 0 (A 0 (A 1 8)))              
; (A 0 (A 0 (A 0 (A 1 7))))        
; (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 5))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 4)))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 3))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 2)))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 1 1))))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 2)))))))))
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 4))))))))     
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 8)))))))            
; (A 0 (A 0 (A 0 (A 0 (A 0 (A 0 16)))))) 
; (A 0 (A 0 (A 0 (A 0 (A 0 32)))))                      
; (A 0 (A 0 (A 0 (A 0 64))))    
; (A 0 (A 0 (A 0 128)))         
; (A 0 (A 0 256))               
; (A 0 512)                                               
; 1024                                               

; (A 2 4)
; (A (- 2 1) (A 2 (- 4 1)))         ; else 조건 적용
; (A 1 (A 2 3))
; (A 1 (A 1 (A 2 2)))               ; (A 2 3) 전개
; (A 1 (A 1 (A 1 (A 2 1))))        ; (A 2 2) 전개
; (A 1 (A 1 (A 1 2)))               ; (A 2 1) = 2 (y=1 조건)
; (A 1 (A 1 (A 0 (A 1 1))))        ; (A 1 2) 전개
; (A 1 (A 1 (A 0 2)))               ; (A 1 1) = 2 (y=1 조건)
; (A 1 (A 1 4))                     ; (A 0 2) = (* 2 2) = 4
; (A 1 (A 0 (A 1 3)))               ; (A 1 4) 전개
; (A 1 (A 0 (A 0 (A 1 2))))        ; (A 1 3) 전개
; (A 1 (A 0 (A 0 (A 0 (A 1 1)))))  ; (A 1 2) 전개
; (A 1 (A 0 (A 0 (A 0 2))))        ; (A 1 1) = 2
; (A 1 (A 0 (A 0 4)))               ; (A 0 2) = 4
; (A 1 (A 0 8))                     ; (A 0 4) = 8
; (A 1 16)                          ; (A 0 8) = 16
; (A 0 (A 1 15))                    ; (A 1 16) 전개 시작
; ...
; 65536                             ; 최종 결과: 2^16

;; (A 0 n) = 2n                     ; 2배
;; (A 1 n) = 2^n                    ; 거듭제곱
;; (A 2 n) = 2^2^2^...^2 (n개)
