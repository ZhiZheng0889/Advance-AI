; Zhi Zheng
; Assignment 2
; CAP5634.01 Advanced Artificial Intelligence

; Vending Machine
;--------------------------------------------------------------------
; SUMMARY:
; This CLIPS code simulates the process of inserting coins to reach a exact amount of 65 cents.
; It defines templates for coins (with type and value) and a state (with the current amount and coin counts).
; The initial states of coins (quarter, dime, nickel) and the machine/user state are provided.
; Rules are defined to add coins (quarter, dime, nickel) to the state without exceeding 65 cents.
; When the exact amount of 65 cents is reached, a solution is printed.
;--------------------------------------------------------------------

; Define a template for coins
(deftemplate coin
  (slot type)  ; Type of the coin
  (slot value))  ; Numerical value of the coin
  
; Initial facts for the available coins and their values
(deffacts coins
  (coin (type "Quarter-Value") (value 25))  ; Define a quarter with a value of 25 cents
  (coin (type "Dime-Value")    (value 10))  ; Define a dime with a value of 10 cents
  (coin (type "Nickel-Value")  (value 5)))  ; Define a nickel with a value of 5 cents

; Define a template for the current state
; This will keep track of the total amount and the count of each coin type
(deftemplate state
  (slot amount)    ; Total amount accumulated so far
  (slot quarters)  ; Number of quarters inserted
  (slot dimes)     ; Number of dimes inserted
  (slot nickels))  ; Number of nickels inserted

; Initial facts for the starting state (no coins inserted yet)
(deffacts initial-state
  (state (amount 0) (quarters 0) (dimes 0) (nickels 0)))

; Rule to add a nickel to the state
; Activates if adding a nickel won't exceed 65 cents
(defrule add-nickel
  ?s <- (state (amount ?a) (quarters ?q) (dimes ?d) (nickels ?n)) ; Match the current state
  (coin (type "Nickel-Value") (value ?v)) ; Match a nickel's value
  (test (<= (+ ?a ?v) 65)) ; Check if adding a nickel won't exceed 65 cents
  =>
  (modify ?s (amount (+ ?a ?v)) (nickels (+ 1 ?n)))) ; Update the state with the new amount and nickel count
  
; Rule to add a dime to the state
; Activates if adding a dime won't exceed 65 cents
(defrule add-dime
  ?s <- (state (amount ?a) (quarters ?q) (dimes ?d) (nickels ?n)) ; Match the current state
  (coin (type "Dime-Value") (value ?v)) ; Match a dime's value
  (test (<= (+ ?a ?v) 65)) ; Check if adding a dime won't exceed 65 cents
  =>
  (modify ?s (amount (+ ?a ?v)) (dimes (+ 1 ?d)))) ; Update the state with the new amount and dime count
  
; Rule to add a quarter to the state
; Activates if adding a quarter won't exceed 65 cents
(defrule add-quarter
  ?s <- (state (amount ?a) (quarters ?q) (dimes ?d) (nickels ?n))  ; Match the current state
  (coin (type "Quarter-Value") (value ?v))  ; Match a quarter's value
  (test (<= (+ ?a ?v) 65))  ; Check if adding a quarter won't exceed 65 cents
  =>
  (modify ?s (amount (+ ?a ?v)) (quarters (+ 1 ?q))))  ; Update the state with the new amount and quarter count

; Rule to check if the desired amount of 65 cents has been reached
; If reached, print the optimal combination of coins
(defrule solution-found
  (state (amount 65) (quarters ?q) (dimes ?d) (nickels ?n))
  =>
  (printout t "Optimal way to purchase a soft drink: " ?q " quarters, " ?d " dimes, " ?n " nickels." crlf)
	)

; To execute the program correctly in CLIPSIDE:
; 1. Load this construct into the environment.
; 2. Set to breadth mode with (set-strategy breadth) command.
; 3. Use the (reset) command to initialize the system.
; 4. Then, trigger the rules using the (run) command.

; Can use (salience) command to set priority to each rule to increase efficiency.
