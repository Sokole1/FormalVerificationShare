(defun move (a b)
  (list 'move a 'to b))

(defun hanoi (a b c n)
  (if (zp n)
    nil
    (if (equal n 1)
        (list (move a c))
    (append (hanoi a c b (1- n))
            (cons (move a c)
                  (hanoi b a c (1- n)))))))

;; Lemma needed for hanoi-moves-required
(defthm len-append
  (equal (len (append x y))
         (+ (len x) (len y))))

(defthm hanoi-moves-required
  (implies (and (integerp n)
                (<= 0 n)) ;; n is at least 0
           (equal (len (hanoi a b c n))
                  (1- (expt 2 n)))))#|ACL2s-ToDo-Line|#


