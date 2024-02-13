(defun sum-sq-inv (n)
  (if (zp n)
      0
      (+ (/ 1 (expt n 2))
         (sum-sq-inv (1- n)))))#|ACL2s-ToDo-Line|#



(defthm sum-sq-inv-bound
     (implies (natp n) 
              (<= (sum-sq-inv n) (- 2 (/ 1 n)))))
