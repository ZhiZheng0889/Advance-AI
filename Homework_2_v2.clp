; Initial state
(deffacts initialization
    (state 0)
    (coins-used 0)
    (coin-history ""))

; Inserting a Quarter
(defrule insert-quarter
   ?current <- (state ?amt)
   ?coinFact <- (coins-used ?c)
   ?history <- (coin-history ?h)
   (not (state ?possible-next-amount&:(= ?possible-next-amount (+ ?amt 25))))
   (test (< ?amt 65))
   =>
   (retract ?current ?coinFact ?history)
   (assert (state (+ ?amt 25)))
   (assert (coins-used (+ ?c 1)))
   (assert (coin-history (str-cat ?h "Quarter "))))

; Inserting a Dime
(defrule insert-dime
   ?current <- (state ?amt)
   ?coinFact <- (coins-used ?c)
   ?history <- (coin-history ?h)
   (not (state ?possible-next-amount&:(= ?possible-next-amount (+ ?amt 10))))
   (test (< ?amt 65))
   =>
   (retract ?current ?coinFact ?history)
   (assert (state (+ ?amt 10)))
   (assert (coins-used (+ ?c 1)))
   (assert (coin-history (str-cat ?h "Dime "))))

; Inserting a Nickel
(defrule insert-nickel
   ?current <- (state ?amt)
   ?coinFact <- (coins-used ?c)
   ?history <- (coin-history ?h)
   (not (state ?possible-next-amount&:(= ?possible-next-amount (+ ?amt 5))))
   (test (< ?amt 65))
   =>
   (retract ?current ?coinFact ?history)
   (assert (state (+ ?amt 5)))
   (assert (coins-used (+ ?c 1)))
   (assert (coin-history (str-cat ?h "Nickel "))))

; Check for Goal State
(defrule reached-goal
    (state ?amt)
    (coins-used ?c)
    (coin-history ?h)
    (test (>= ?amt 65))
    =>
    (printout t "Optimal purchase reached using " ?c " coins. Coins used: " ?h crlf))

; Prevent infinite loop by limiting the number of coins to a reasonable limit (for example 10)
(defrule max-coins-used
    (coins-used ?c)
    (test (>= ?c 10))
    =>
    (printout t "Too many coins used without reaching the goal." crlf))
