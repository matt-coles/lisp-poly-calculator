;; Add two polynomials together
(defun poly+ (poly1 poly2)
  (add-terms (append poly1 poly2)))

;; Subtract one polynomial from another
(defun poly- (poly1 poly2)
  (add-terms (append poly1 (flip-multipliers poly2))))

;; Returns the variable component of a singular polynomial
(defun variable-symbol (single-poly)
  (car (car single-poly)))

;; Returns the exponent component of a singular polynomial
(defun exponent (single-poly)
  (car (cdr (car single-poly))))

;; Returns the multiplier component of a singular polynomial
(defun multiplier (single-poly)
  (car (cdr single-poly)))

;; Returns a polynomial with all the multipliers multiplied by -1
(defun flip-multipliers (poly)
  (map 'list #'(lambda (x) 
                 (list (list (variable-symbol x) (exponent x))
                       (* (multiplier x) -1))) poly))

;; Returns an added term if the addition is succesful, nil otherwise
(defun term-addition (term1 term2)
  (if (and (equal (variable-symbol term1) (variable-symbol term2))
           (equal (exponent term1) (exponent term2)))
    (list (list (variable-symbol term1) (exponent term1)) 
          (+ (multiplier term1) (multiplier term2)))
    nil))

;; Returns the failed term if the addition fails, nil otherwise
(defun term-failure (term1 term2)
  (if (and (equal (variable-symbol term1) (variable-symbol term2))
           (equal (exponent term1) (exponent term2)))
    nil
    term2))

;; Returns true if a polynomial contains only unique terms
(defun poly-unique-terms? (poly)
  (cond ((equal poly nil) T)
  (T (if (some #'(lambda (x) (equal (car x) (car (car poly)))) (cdr poly))
    nil
    (poly-unique-terms? (cdr poly))))))

;; This function replaces a full list of nils with the replace-term, otherwise
;; returns the list
(defun useful-replace-nil (addition-seq replace-term)
  (if (equal (remove nil addition-seq) nil)
    (list replace-term)
    addition-seq))

;; Removes all zeroes from the polynomial
(defun clear-zero (poly)
  (remove nil (map 'list #'(lambda (x)
                 (if (equal (multiplier x) 0) nil x)) poly)))

;; Recursively adds all the terms in the list
(defun add-terms (poly)
  (cond
    ((poly-unique-terms? poly) (clear-zero poly))
    (T (add-terms (remove nil (append (map 'list #'(lambda (x)
                                     (term-failure (car poly) x))
                           (cdr poly))
        (useful-replace-nil (map 'list #'(lambda (y)
                       (term-addition (car poly) y))
             (cdr poly)) (car poly))))))))

; (poly+ '(((x 2) 3)) '(((y 2) 4)))
; (poly+ '(((x 2) 3) ((y 2) 3)) '(((y 2) 4)))
