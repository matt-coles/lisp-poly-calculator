;; Add two polynomials together
(defun poly+ (poly1 poly2)
  (add-terms (append poly1 poly2)))

;; Subtract one polynomial from another
(defun poly- (poly1 poly2)
  (add-terms (append poly1 (flip-multipliers poly2))))

;; Multiply polynomials together
(defun poly* (poly1 poly2)
  (clear-zero (add-terms (multiply-terms poly1 poly2))))

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
  (T (if (some #'(lambda (x) (and (equal (flatten 
                                                  (variable-symbol x))
                                                (flatten 
                                                  (variable-symbol 
                                                    (car poly))))
                              (equal (flatten (exponent x))
                                     (flatten (exponent (car poly))))))
               (cdr poly))
    nil
    (poly-unique-terms? (cdr poly))))))

;; Functional flatten from Rosetta Code: 
;; http://rosettacode.org/wiki/Flatten_a_list#Common_Lisp
(defun flatten (x &optional stack out)
  (cond ((consp x) (flatten (rest x) (cons (first x) stack) out))
        (x         (flatten (first stack) (rest stack) (cons x out)))
        (stack     (flatten (first stack) (rest stack) out))
        (t out)))

;; This function replaces a full list of nils with the replace-term, otherwise
;; returns the list
(defun useful-replace-nil (addition-seq replace-term)
  (if (equal (remove nil addition-seq) nil)
    (list replace-term)
    addition-seq))

;; Removes all zeroes from the polynomial
(defun clear-zero (poly)
  (remove nil (map 'list #'(lambda (x)
                 (if (or (equal (multiplier x) 0) (equal (exponent x) 0)) nil x)) 
                   poly)))

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

;; Map a single polynomial onto each term of another polynomial
(defun map-onto-poly (single-poly poly)
  (map 'list #'(lambda (x) (multiply-singles single-poly x)) poly))

;; Multiply two singular polynomials together
(defun multiply-singles (single-poly1 single-poly2)
  (cond
    ((equal (variable-symbol single-poly1) (variable-symbol single-poly2))
     (list (list (variable-symbol single-poly1) 
                 (if (typep (exponent single-poly1) 'list)
                   (map 'list #'+ (exponent single-poly1) 
                        (exponent single-poly2))
                   (+ (exponent single-poly1) (exponent single-poly2))))
           (* (multiplier single-poly1) (multiplier single-poly2)))
    )
    (T
      (list (list (list (variable-symbol single-poly1)
                        (variable-symbol single-poly2))
                  (list (exponent single-poly1)
                        (exponent single-poly2)))
            (* (multiplier single-poly1) (multiplier single-poly2))))))

;; Multiply two polynomials together, see the map-poly will be recursed
;; and the poly will remain constant
(defun multiply-terms (map-poly poly)
  (cond
    ((equal map-poly nil) nil)
    (T (remove nil (append (map-onto-poly (car map-poly) poly) 
               (multiply-terms (cdr map-poly) poly))))))
