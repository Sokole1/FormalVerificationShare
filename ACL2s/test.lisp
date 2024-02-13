;$ACL2s-SMode$;ACL2s
(definec successor (x :int) :int (1+ x))

(in-package "ACL2S")

; Computes the nth fibonacci number
(definec fib (n :nat) :nat
  (match n
    ((:or 0 1) 1)
    (& (+ (fib (1- n)) (fib (- n 2))))))#|ACL2s-ToDo-Line|#




