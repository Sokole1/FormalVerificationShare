;; https://www.cs.utexas.edu/users/moore/acl2/manuals/latest/index.html?topic=ACL2____TUTORIAL2-EIGHTS-PROBLEM

(defun bump-i (x)
  ;; Bump the i component of the pair
  ;; (i . j) by 1.
  (cons (1+ (car x)) (cdr x)))

(defun split (n)
  ;; Find a pair (i . j) such that
  ;; n = 3i + 5j.
  (if (or (zp n) (< n 8))
      nil ;; any value is really reasonable here
    (if (equal n 8)
        (cons 1 1)
      (if (equal n 9)
          (cons 3 0)
        (if (equal n 10)
            (cons 0 2)
          (bump-i (split (- n 3))))))))

(defthm split-splits
  (let ((i (car (split n)))
        (j (cdr (split n))))
    (implies (and (integerp n)
                  (< 7 n))
             (and (integerp i)
                  (<= 0 i)
                  (integerp j)
                  (<= 0 j)
                  (equal (+ (* 3 i) (* 5 j))
                         n)))))


(defun-sk split-able (n)
  (exists (i j)
          (equal n (+ (* 3 i) (* 5 j)))))

(defthm split-splits2
  (implies (and (integerp n)
                (< 7 n))
           (split-able n))
  :hints (("Goal" :use (:instance split-able-suff
                                  (i (car (split n)))
                                  (j (cdr (split n)))))))#|ACL2s-ToDo-Line|#


