;; https://www.quora.com/How-do-I-prove-sum_-k-1-n-frac-1-k-2-leq-2-frac-1-n-using-induction

(defun inverse-square-sum (n)
  (if (zp n)
    0
    (+ (/ (* n n)) (inverse-square-sum (1- n)))))#|ACL2s-ToDo-Line|#



  
(defthm inverse-square-sum-leq
  (implies (and (natp n)
                (>= n 1))
           (<= (inverse-square-sum n)
               (- 2 (/ 1 n)))))
