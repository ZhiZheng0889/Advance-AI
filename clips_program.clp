
; Global variable to store the total number of adults
(defglobal ?*total-adults* = 0)

; Define a template for a person
(deftemplate person
    (slot name)
    (slot age)
    (slot isAdult (default no)))

; Assert some facts
(deffacts initial-facts
    (person (name "John") (age 30))
    (person (name "Doe") (age 25))
    (person (name "Jane") (age 17)))

; Define a rule to check if a person is adult
(defrule is-adult
    ?p <- (person (name ?name) (age ?age) (isAdult no))
    (test (> ?age 18))
=>
    (printout t ?name " is an adult." crlf)
    (modify ?p (isAdult yes))
    (increment ?*total-adults*))

; Rule to print the total number of adults
(defrule print-total-adults
    (not (person (isAdult no)))
=>
    (printout t "Total number of adults: " ?*total-adults* crlf))

; Define a function to add two numbers
(deffun add-numbers (?a ?b)
    (+ ?a ?b))

; Custom function to increment the global variable
(deffun increment (?value)
    (bind ?*total-adults* (+ ?*total-adults* ?value)))
