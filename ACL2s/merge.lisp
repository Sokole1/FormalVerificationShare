; Based on CPSC 110 (@assignment bank/2-one-of-p2) - "merge-solution.rkt"
; https://cs110.students.cs.ubc.ca/bank/
(include-book "acl2s/cgen/top" :dir :system :ttags :all) ; Import CGEN
(acl2s-defaults :set testing-enabled t)                  ; Enable counter examples

(defun add-lists (list1 list2)
  (if (or (endp list1) (endp list2)) ; Base case: one or both lists are empty
      nil  ; Return an empty list
      (cons (+ (car list1) (car list2)) ; Add elements, recurse on rest
            (add-lists (cdr list1) (cdr list2))))) 

#| ========= From CPSC 110 ================
;; produce sorted list of numbers by merging two sorted lists of numbers

(check-expect (merge empty empty) empty)
(check-expect (merge empty (list 1 3 5)) (list 1 3 5))
(check-expect (merge (list 0 2 4) empty) (list 0 2 4))
(check-expect (merge (list 0 2 4) (list 1 3)) (list 0 1 2 3 4))

(define (merge l1 l2)
  (cond [(empty? l1) l2]  ;(1)                 
        [(empty? l2) l1]  ;(2)                  
        [else             ;(3)                   
         (if (<= (first l1) (first l2))
             (cons (first l1)
                   (merge (rest l1) l2))
             (cons (first l2)
                   (merge l1 (rest l2))))]))
|#

; ================ ACL2 Version ===================
(defun merge-sorted-lists (l1 l2) 
    (declare (xargs :measure (+ (len l1) (len l2)))) ; Need the right measure for this to pass
    (cond ((endp l1) l2)
          ((endp l2) l1)
          (T
           (if (<= (car l1) (car l2))
               (cons (car l1)
                     (merge-sorted-lists (cdr l1) l2))
               (cons (car l2)
                     (merge-sorted-lists l1 (cdr l2)))))))

#| Prove the following properties of merge-sorted-lists:

1. Length of output is the length of l1 + l2
2. All elements of l1 and l2 are present in output
3. If the original two lists were sorted, the output should be sorted

|#

; 1.
(defthm merge-sorted-lists-correct-length
  (implies
   (and
    (listp l1)
    (listp l2))
   (equal (len (merge-sorted-lists l1 l2))
          (+ (len l1) (len l2)))))

; 2.
(defthm merge-sorted-lists-contains-all-elements
  (implies
   (or
    (member x l1)
    (member x l2))
   (member x (merge-sorted-lists l1 l2))))


; 3.
(defun is-sorted-non-decreasing (lst)
  (cond ((endp lst) T)
        ((endp (cdr lst)) T)
        ((> (car lst) (cadr lst)) nil)
        (T
         (is-sorted-non-decreasing (cdr lst)))))

#| Proof of merge-sorted-lists-still-sorted fails with this version
(defun is-sorted-non-decreasing (lst)
  (if (or (endp lst) (equal (len lst) 1))
    T
    (if (> (car lst) (cadr lst))
      nil
      (is-sorted-non-decreasing (cdr lst)))))
|#

(defthm merge-sorted-lists-still-sorted
  (implies
   (and
    (nat-listp l1)
    (nat-listp l2)
    (is-sorted-non-decreasing l1)
    (is-sorted-non-decreasing l2))
   (is-sorted-non-decreasing (merge-sorted-lists l1 l2))))#|ACL2s-ToDo-Line|#


#| ----- Not sure how to do this ---------
(defthm is-sorted-non-decreasing-correct
  (implies
   (and
    (is-sorted-non-decreasing lst)
    (member x lst)
    (> y x))
   
   (or (not (member y lst))
       (< (position x lst) (position y lst)))))
|#

#|
(defthm is-sorted-ascending-correct
  (implies
   (and
    (rational-listp lst)
    (is-sorted-ascending lst)
    (>= (len lst) 2)
    (natp x)
    (natp y)
    (< x y)
    (<= 0 x)
    (< y (len lst)))
   (<= (nth x lst) (nth y lst))))
|#

#|
(defthm merge-sorted-lists-still-sorted
  (implies
   (and
    (rational-listp l1)
    (rational-listp l2)
    (is-sorted-non-decreasing l1)
    (is-sorted-non-decreasing l2))
   (is-sorted-non-decreasing (merge-sorted-lists l1 l2))))
|#
#| Verify is-sorted-ascending, this fails
(defthm is-sorted-ascending-correct
  (implies
   (and
    (is-sorted-ascending lst)
    (< (position x lst) (position y lst))
    
    (member x lst)
    (member y lst))
   (<= x y)))
|#






    