

(setf *print-case* :downcase)


(defun split-str (chars sep)
  (cond
    ((null chars) (cons nil nil))
    ((char= (car chars) sep) (cons nil (cdr chars)))
    (t (let ((rec (split-str (cdr chars) sep)))
        (cons (cons (car chars) (car rec)) (cdr rec))
      ))
    )
  )
 
(defun to-int-range (str-range)
  (cons (parse-integer (coerce (car str-range) 'string))
        (parse-integer (coerce (cdr str-range) 'string)))
)

(defun add-range (ranges range)
  (cond
    ((not ranges) (cons range nil))
    (t (let ((fst-range (car ranges))) (cond
      ((and (<= (car range) (car fst-range)) (<= (cdr fst-range) (cdr range))) (add-range (cdr ranges) range))
      ((and (<= (car range) (car fst-range)) (<= (car fst-range) (cdr range))) (add-range (cdr ranges) (cons (car range) (cdr fst-range))))
      ((and (<= (car range) (cdr fst-range)) (<= (cdr fst-range) (cdr range))) (add-range (cdr ranges) (cons (car fst-range) (cdr range))))
      ((and (>= (car range) (car fst-range)) (>= (cdr fst-range) (cdr range))) ranges)
      ((< (cdr range) (car fst-range)) (cons fst-range (add-range (cdr ranges) range)))
      ((> (car range) (cdr fst-range)) (cons fst-range (add-range (cdr ranges) range)))
    )))
  )
)

(defun read-range (others) 
  (let ((range-str (read-line *STANDARD-INPUT* nil))) 
    (cond
      ((and range-str (not (null (coerce range-str 'list))))
       (read-range (add-range others (to-int-range (split-str (coerce range-str 'list) #\-)))))
      (t others)
    ))
) 

(defun total-ids (ranges)
  (cond
    ((not ranges) 0)
    (t (+ (+ (- (cdr (car ranges)) (car (car ranges))) (total-ids (cdr ranges))) 1))
  )
)

(defun main () 
  (let ((ranges (read-range nil)))
    (print (total-ids ranges))
  )
)

(main)

