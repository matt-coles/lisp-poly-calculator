(defun poly+ (poly1 poly2)
  (format t "Poly One: ~d~%" poly1)
  (format t "Poly Two: ~d~%" poly2)
  (if (equal (length poly1) 1)
    (format t "Poly 1 has exactly one term: ~a Ex: ~a Mul: ~a~%" 
            (find-variable-symbol poly1)
            (find-exponent        poly1)
            (find-multiplier      poly1))
    (format t "Poly 1 has more than one term~%")))

(defun collect-like-terms (poly)
  (format t "collecting terms"))

(defun find-variable-symbol (single-poly)
  (car (car (car single-poly))))

(defun find-exponent (single-poly)
  (cdr (car (car single-poly))))

(defun find-multiplier (single-poly)
  (cdr (car single-poly)))

(poly+ '(((x 2) 3)) '(((y 2) 4)))
(poly+ '(((x 2) 3) ((y 2) 3)) '(((y 2) 4)))
