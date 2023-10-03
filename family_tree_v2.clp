; CLIPS Exercise 3
; Student Name: Zhi Zheng
; Family Trees
; ...

; Define the parent-of template which holds information about the parent and their child.
(deftemplate parent-of
	(multislot parent)
	(multislot child))

; Define the input-name template which will be used to store the name inputted by the user.
(deftemplate input-name
	(multislot name))

; Define the initial facts of our family tree.
(deffacts the-family-tree
	(parent-of (parent Albert Wong) (child Tony Wong))
	(parent-of (parent Albert Wong) (child Sandy Wong))
	(parent-of (parent Tony Wong) (child Allen Wong))
	(parent-of (parent Tony Wong) (child Newman Wong))
	(parent-of (parent Sandy Wong) (child Mendy Bai))
	(parent-of (parent Sandy Wong) (child Nancy Bai))
	; Adding another generation
	(parent-of (parent Allen Wong) (child Peter Wong))
	(parent-of (parent Allen Wong) (child Anna Wong))
	(parent-of (parent Newman Wong) (child Sophie Wong))
	(parent-of (parent Mendy Bai) (child Lucas Bai))
	(parent-of (parent Mendy Bai) (child Emily Bai))
	(parent-of (parent Nancy Bai) (child Leo Bai))
)

; Rule to prompt the user for a name.
(defrule get-name
   =>
   (printout t "Please enter the first name: ")
   (bind ?first-name (read))
   (printout t "Please enter the last name: ")
   (bind ?last-name (read))
   (assert (input-name (name ?first-name ?last-name))))  

; Rule to find cousins that are in the same generation as the entered name.
(defrule find-same-generation-cousins
    (input-name (name ?first-name ?last-name))
    (parent-of (parent ?parent1 ?parent2) (child ?first-name ?last-name))
    (parent-of (parent ?grandparent1 ?grandparent2) (child ?parent1 ?parent2))
    (parent-of (parent ?great-grandparent1 ?great-grandparent2) (child ?grandparent1 ?grandparent2))
    (parent-of (parent ?great-grandparent1 ?great-grandparent2) (child ?other-grandparent1 ?other-grandparent2))
    (parent-of (parent ?other-grandparent1 ?other-grandparent2) (child ?other-parent1&~?parent1 ?other-parent2))
    (parent-of (parent ?other-parent1 ?other-parent2) (child ?cousin1&~?first-name ?cousin2))
    =>
    (printout t ?cousin1 " " ?cousin2 " is a cousin of " ?first-name " " ?last-name " at the same generational level." crlf))
	


