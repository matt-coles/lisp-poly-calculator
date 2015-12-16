# LISP Polynomial Calculator

* A simple polynomial calculator in lisp

* Polynomials are in the form 
    '(((SYMBOL EXPONENT) MULTIPLIER) ((SYMBOL EXPONENT) MULTIPLIER))

* For example this:
    '(((x 2) 5) ((((x y) (2 3)) 5))) = 5x^2 + 5x^2y^3

* The functions that exist are poly+ poly- poly*

Below you can see an example of the test output:

    [25]> (load "tests.cl")
    ;; Loading file tests.cl ...
    ;;  Loading file poly.cl ...
    ;;  Loaded file poly.cl
    ;; Loaded file tests.cl
    T
    [26]> (run-tests)
    5x^2 + 3x^2 ... passed - simple addition
    5x^2+6y^2 + 3x^2+3y^2+4z^3 ... passed - complex addition
    5x^2 - 3x^2 ... passed - simple subtraction
    5x^2+6y^2 - 3x^2+3y^2+4z^3 ... passed - complex subtraction
    5x^2 * 5x^2 ... passed - simple multiplication
    (5x^2+y^2) * (3x + y) ... passed - complex multiplication
    T
    [27]>

