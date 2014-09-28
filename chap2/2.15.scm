; Eva is right.
; The expressions are algebraically equivalent only with certain arguments.
; However, intervals are represented with uncertain values and each interval used
; in the an computation increases the uncertainty of the final result.
; Even if we represent value with certain values, rounding errors still come from
; the finite-precision arithmetic operations of real computers.
; Expression `R1 * R2 / (R1 + R2)' uses the uncertain values `R1' and `R2' twice
; during the computations while expression `1 / ((1 / R1) + (1 / R2))' uses the
; same arguments only once, which makes the result of `par2' less uncertain and
; therefore better.
