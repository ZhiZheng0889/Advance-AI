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
	(parent-of (parent "Albert Wong") (child "Tony Wong"))
	(parent-of (parent "Albert Wong") (child "Sandy Wong"))
	(parent-of (parent "Tony Wong") (child "Allen Wong"))
	(parent-of (parent "Tony Wong") (child "Newman Wong"))
	(parent-of (parent "Sandy Wong") (child "Mendy Bai"))
	(parent-of (parent "Sandy Wong") (child "Nancy Bai"))
	; Adding another generation
	(parent-of (parent "Allen Wong") (child "Peter Wong"))
	(parent-of (parent "Allen Wong") (child "Anna Wong"))
	(parent-of (parent "Newman Wong") (child "Sophie Wong"))
	(parent-of (parent "Mendy Bai") (child "Lucas Bai"))
	(parent-of (parent "Mendy Bai") (child "Emily Bai"))
	(parent-of (parent "Nancy Bai") (child "Leo Bai"))
)

; Rule to prompt the user for a name.
(defrule get-name
	=>
	(printout t "Please enter a name: ")
	(assert (input-name (name (readline)))))

; Rule to find cousins that are in the same generation as the entered name.
(defrule find-same-generation-cousins
    (input-name (name ?name))
    (parent-of (parent ?parent) (child ?name))
    (parent-of (parent ?grandparent) (child ?parent))
    (parent-of (parent ?great-grandparent) (child ?grandparent))
    (parent-of (parent ?great-grandparent) (child ?other-grandparent))
    (parent-of (parent ?other-grandparent) (child ?other-parent&~?parent))
    (parent-of (parent ?other-parent) (child ?cousin&~?name))
    =>
    (printout t ?cousin " is a cousin of " ?name " at the same generational level." crlf))

; Rule to find first cousins (without considering great-grandparents) for the entered name.
(defrule find-cousins-without-greats
    (input-name (name ?name))
    (parent-of (parent ?parent) (child ?name))
    (parent-of (parent ?grandparent) (child ?parent))
    (parent-of (parent ?grandparent) (child ?uncle-aunt&~?parent&~?name))
    (parent-of (parent ?uncle-aunt&~?parent) (child ?cousin&~?name))
    =>
    (printout t ?cousin " is a cousin of " ?name " through uncle/aunt " ?uncle-aunt crlf))
