; Define a template for the car status
(deftemplate car-status
    (slot brake-pressure (type NUMBER))
    (slot car-speed (type SYMBOL))
    (slot wheel-speed (type SYMBOL))
    (slot brake-action (default ?NONE) (type SYMBOL)))

; Define rules
(defrule rule1
    (car-status (brake-pressure ?p) (car-speed fast) (wheel-speed fast))
    (test (and (>= ?p 50) (<= ?p 70))) ; Medium brake pressure
    =>
    (modify ?* (brake-action apply)))

(defrule rule2
    (car-status (brake-pressure ?p) (car-speed fast) (wheel-speed fast))
    (test (> ?p 70)) ; High brake pressure
    =>
    (modify ?* (brake-action apply)))

(defrule rule3
    (car-status (brake-pressure ?p) (car-speed fast) (wheel-speed slow))
    (test (> ?p 70)) ; High brake pressure
    =>
    (modify ?* (brake-action release)))

(defrule rule4
    (car-status (brake-pressure ?p))
    (test (< ?p 30)) ; Low brake pressure
    =>
    (modify ?* (brake-action release)))

; Example: Initialize a car-status
(assert (car-status (brake-pressure 60) (car-speed fast) (wheel-speed fast)))

; Run the inference engine
(run)
