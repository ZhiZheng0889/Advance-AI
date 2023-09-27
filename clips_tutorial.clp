; Adventures in Rule-based Programming: A CLIPS Tutorial

; ===================
; TEMPLATES DEFINITION
; ===================

; Define the structure of objects/characters in the game world.
(deftemplate thing
    (slot id)          ; Identifier of the object/character
    (slot category)    ; Category to which the object/character belongs
    (slot location))   ; Current location of the object/character

; Define the structure of commands given by the player.
(deftemplate command
    (multislot action))  ; Actions can have multiple components (e.g., "go north")

; ===================
; INITIALIZATION FUNCTION
; ===================

; Function to initialize the game state.
(deffunction initialize-adventure ()
    (assert (thing (id adventurer) (category actor) (location pit_north)))
    (assert (command (action climb up)))
    (assert (command (action go north)))
)

; ===================
; ENVIRONMENT DESCRIPTIONS
; ===================

; Rule for describing the north end of the pit.
(defrule pit_north
    (thing (id adventurer)
           (location pit_north))
=>
    (println "You're at the pit's north end.")
    (println "A giant mushroom is here. The")
    (println "ground is littered with the")
    (println "bodies of dead adventurers."))

; Rule for describing the south end of the pit.
(defrule pit_south 
    (thing (id adventurer) 
           (location pit_south))
=>
    (println "You're at the pit's south end.")
    (println "A large pile of rubble has")
    (println "collapsed from the wall above."))

; ===================
; INTRODUCTORY RULE
; ===================
(defrule exposition
=>
    (println "Captured by goblins, you've been")
    (println "tossed in a pit at their lair."))

; ===================
; MOVEMENT & INTERACTION RULES
; ===================

; Rule to handle failed escape attempts.
(defrule no_escape 
    (thing (id adventurer) 
           (location pit_north | pit_south)) 
    ?c <- (command (action climb | go up)) 
=>
    (retract ?c)
    (println "The walls are too slick."))

; Rule to move from the north end to the south end of the pit.
(defrule south_from_pit_north 
    ?p <- (thing (id adventurer) 
                (location pit_north)) 
    ?c <- (command (action go south)) 
=>
    (retract ?c)
    (modify ?p 
            (location pit_south)))

; Rule to move from the south end to the north end of the pit.
(defrule north_from_pit_south 
    ?p <- (thing (id adventurer) 
                (location pit_south)) 
    ?c <- (command (action go north)) 
=>
    (retract ?c)
    (modify ?p 
            (location pit_north)))

; Rule to inform player of invalid directions from the north end.
(defrule bad_go_from_pit_north 
    (thing (id adventurer) 
           (location pit_north)) 
    ?c <- (command (action go ~south&~up))
=>
    (retract ?c)
    (println "You can't go there."))
