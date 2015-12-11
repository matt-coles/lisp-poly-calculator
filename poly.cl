(defun poly+ (poly1 poly2)
  (add-terms poly1 poly2))

(defun variable-symbol (single-poly)
  (car (car (car single-poly))))

(defun exponent (single-poly)
  (cdr (car (car single-poly))))

(defun multiplier (single-poly)
  (cdr (car single-poly)))

(defun is-single-poly (var-poly)
  (if (equal (length var-poly) 1) T nil))

(defun add-terms (poly1 poly2)
  (if (equal (is-single-poly poly1) (is-single-poly poly2))
  (cons poly1 poly2)
  (progn
    )
  ))

(poly+ '(((x 2) 3)) '(((y 2) 4)))
; (poly+ '(((x 2) 3) ((y 2) 3)) '(((y 2) 4)))
