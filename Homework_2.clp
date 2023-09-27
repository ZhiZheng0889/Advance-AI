; VendingMachine.clp
;
; Problem Description:
; A vending machine accepts quarters, dimes, and nickels.
; We aim to find the optimal way (using the least number of coins) to make a purchase of 65 cents.

(defglobal
    ?*QUARTER-VALUE* = 25
    ?*DIME-VALUE* = 10
    ?*NICKEL-VALUE* = 5
)

; Facts representing the coins and their values
(deffacts coins-values
    (coin quarter ?*QUARTER-VALUE*)
    (coin dime ?*DIME-VALUE*)
    (coin nickel ?*NICKEL-VALUE*)
)

; Starting fact for the current amount
(deffacts starting-amount
    (current-amount 0)
)

; Insert as many quarters as possible without exceeding 65 cents.
(defrule insert-quarter
    ?f <- (current-amount ?x)
    (coin quarter ?value)
    (test (< (+ ?x ?value) 66))
    =>
    (retract ?f)
    (assert (current-amount (+ ?x ?value)))
    (printout t "Inserted a quarter. Current amount: " (+ ?x ?value) " cents." crlf)
)

; Insert as many dimes as possible when quarters are no longer optimal.
(defrule insert-dime
    ?f <- (current-amount ?x)
    (coin dime ?value)
    (coin quarter ?qvalue)
    (test (>= (+ ?x ?qvalue) 66))
    (test (< (+ ?x ?value) 66))
    =>
    (retract ?f)
    (assert (current-amount (+ ?x ?value)))
    (printout t "Inserted a dime. Current amount: " (+ ?x ?value) " cents." crlf)
)

; Insert nickels when dimes and quarters are no longer optimal.
(defrule insert-nickel
    ?f <- (current-amount ?x)
    (coin nickel ?value)
    (coin dime ?dvalue)
    (coin quarter ?qvalue)
    (test (>= (+ ?x ?dvalue) 66))
    (test (>= (+ ?x ?qvalue) 66))
    (test (< ?x 65))
    =>
    (retract ?f)
    (assert (current-amount (+ ?x ?value)))
    (printout t "Inserted a nickel. Current amount: " (+ ?x ?value) " cents." crlf)
)

; Rule to halt the execution when the purchase is complete
(defrule purchase-complete
    ?f <- (current-amount ?x)
    (test (>= ?x 65))
    =>
    (retract ?f)
    (assert (completed)) ; Assert the completed fact
    (printout t "Purchase complete! You have inserted a total of " ?x " cents." crlf)
    (halt) ; This will stop the rule execution
)

; Reset rule to initialize the program
(defrule reset
    ?f <- (current-amount ?x)
    ?c <- (completed)
    =>
    (retract ?f ?c)
    (assert (current-amount 0))
    (printout t "Vending machine reset. Current amount: 0 cents." crlf)
)

; Main function to run the program
(deffunction main ()
    (reset)
    (run) ; This will cause CLIPS to execute the rules
)
