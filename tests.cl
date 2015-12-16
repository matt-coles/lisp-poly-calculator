(require "poly.cl")

(defun run-tests ()
  (if (equal 
        (poly+ '(((x 2) 5)) '(((x 2) 3)))
        '(((x 2) 8)))
    (format t "5x^2 + 3x^2 ... passed - simple addition~%")
    (format t "5x^2 + 3x^2 ... failed - simple addition~%"))
  (if (equal
        (poly+ '(((x 2) 5) ((y 2) 6)) '(((x 2) 3) ((y 2) 3) ((z 3) 4)))
        '(((z 3) 4) ((x 2) 8) ((y 2) 9)))
    (format t "5x^2+6y^2 + 3x^2+3y^2+4z^3 ... passed - complex addition~%")
    (format t "5x^2+6y^2 + 3x^2+3y^2+4z^3 ... failed - complex addition~%"))
  (if (equal 
        (poly- '(((x 2) 5)) '(((x 2) 3)))
        '(((x 2) 2)))
    (format t "5x^2 - 3x^2 ... passed - simple subtraction~%")
    (format t "5x^2 - 3x^2 ... failed - simple subtraction~%"))
  (if (equal
        (poly- '(((x 2) 5) ((y 2) 6)) '(((x 2) 3) ((y 2) 3) ((z 3) 4)))
        '(((z 3) -4) ((x 2) 2) ((y 2) 3)))
    (format t "5x^2+6y^2 - 3x^2+3y^2+4z^3 ... passed - complex subtraction~%")
    (format t "5x^2+6y^2 - 3x^2+3y^2+4z^3 ... failed - complex subtraction~%"))
  (if (equal
        (poly* '(((x 2) 5)) '(((x 2) 5)))
        '(((x 4) 25)))
    (format t "5x^2 * 5x^2 ... passed - simple multiplication~%")
    (format t "5x^2 * 5x^2 ... failed - simple multiplication~%"))
  (if (equal
        (poly* '(((x 2) 5) ((y 2) 1)) '(((x 1) 3) ((y 1) 1)))
        '(((X 3) 15) (((X Y) (2 1)) 5) (((Y X) (2 1)) 3) ((Y 3) 1)))
    (format t "(5x^2+y^2) * (3x + y) ... passed - complex multiplication~%")
    (format t "(5x^2+y^2) * (3x + y) ... failed - complex multiplication~%"))
  )
