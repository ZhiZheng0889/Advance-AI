; Zhi Zheng
; Advance Artificial Intelligence

; VendingMachine.clp
;
; Problem Description:
; I've designed a vending machine that accepts quarters, dimes, and nickels.
; My goal is to find the most efficient way (using the fewest number of coins) to make a purchase of 65 cents.

; Using facts to define the constants.
(deffacts global-values
    (changes QUARTER-VALUE value 25)
    (changes DIME-VALUE value 10)
    (changes NICKEL-VALUE value 5)
)

; Here, I'm setting up the initial facts that represent the value of each coin.
(deffacts coins-values
    (coin quarter)
    (coin dime)
    (coin nickel)
)

; I'm initializing the starting amount to zero. This represents the amount currently inserted into the machine.
(deffacts starting-amount
    (current-amount 0)
)

; If neither quarters nor dimes are optimal, I'll insert nickels.
(defrule insert-nickel
    ?f <- (current-amount ?x)
    (changes NICKEL-VALUE value ?value)
    (changes DIME-VALUE value ?dvalue)
    (changes QUARTER-VALUE value ?qvalue)
    (test (>= (+ ?x ?dvalue) 66))
    (test (>= (+ ?x ?qvalue) 66))
    (test (< ?x 65))
    =>
    (retract ?f)
    (assert (current-amount (+ ?x ?value)))
    (printout t "Inserted a nickel. Current amount: " (+ ?x ?value) " cents." crlf)
)

; If inserting another quarter would exceed 65 cents, I'll then try to insert dimes.
(defrule insert-dime
    ?f <- (current-amount ?x)
    (changes DIME-VALUE value ?value)
    (changes QUARTER-VALUE value ?qvalue)
    (test (>= (+ ?x ?qvalue) 66))
    (test (< (+ ?x ?value) 66))
    =>
    (retract ?f)
    (assert (current-amount (+ ?x ?value)))
    (printout t "Inserted a dime. Current amount: " (+ ?x ?value) " cents." crlf)
)

; In this rule, I'm trying to insert as many quarters as possible without going over 65 cents.
(defrule insert-quarter
    ?f <- (current-amount ?x)
    (changes QUARTER-VALUE value ?value)
    (test (< (+ ?x ?value) 66))
    =>
    (retract ?f)
    (assert (current-amount (+ ?x ?value)))
    (printout t "Inserted a quarter. Current amount: " (+ ?x ?value) " cents." crlf)
)

; Once I've achieved the required amount for the purchase, I'll trigger this rule, because the other rules will continue as a loop if it is not halt.
(defrule purchase-complete
    ?f <- (current-amount ?x)
    (test (>= ?x 65))
    =>
    (retract ?f)
    (assert (completed)) ; I'm marking the purchase as completed.
    (printout t "Purchase complete! You have inserted a total of " ?x " cents." crlf)
)

; This is the main function. I'll run it to start the program.
(deffunction main ()
    (reset)
	; I'm instructing CLIPS to begin executing the rules.
    (run) 
)
