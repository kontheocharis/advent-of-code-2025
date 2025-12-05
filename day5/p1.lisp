

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

(defun in-range (range val)
  (and (<= (car range) val) (<= val (cdr range)))
)

(defun read-range (others) 
  (let ((range-str (read-line *STANDARD-INPUT* nil))) 
    (cond
      ((and range-str (not (null (coerce range-str 'list))))
       (read-range (cons (to-int-range (split-str (coerce range-str 'list) #\-)) others)))
      (t others)
    ))
) 

(defun read-vals (others) 
  (let ((val (read-line *STANDARD-INPUT* nil))) 
    (cond
      (val (read-vals (cons (parse-integer val) others)))
      (t others)
    ))
) 

(defun in-ranges (ranges val)
  (cond
    ((not ranges) nil)
    (t (or (in-range (car ranges) val) (in-ranges (cdr ranges) val)))
  )
)

(defun count-present (ranges vals)
  (cond
    ((not vals) 0)
    (t (cond
      ((in-ranges ranges (car vals)) (+ 1 (count-present ranges (cdr vals))))
      (t (count-present ranges (cdr vals)))
    ))
  )
)


(defun main () 
  (let ((ranges (read-range nil)) (vals (read-vals nil)))
    (print (count-present ranges vals))
  )
)

(main)

