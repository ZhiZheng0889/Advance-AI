; CLIPS Exercise 2
; Student Name: Zhi Zheng
; Inferring the Full Path Routing Table of a Given Network
; ...

; Define a template 'path' with a multislot named 'nodes'
; Multislot allows storing multiple values in a single slot.
(deftemplate path
 (multislot nodes))
 
; Define a set of initial facts (direct paths in this case)
; These will be loaded into the fact list every time the environment is reset.
(deffacts direct-paths
	(path (nodes A B)) ; Direct path from A to B
	(path (nodes B C)) ; Direct path from B to C
	(path (nodes B D)) ; Direct path from B to D
	(path (nodes D E)) ; Direct path from D to E
	(path (nodes E F))) ; Direct path from E to F

; Rule to infer indirect paths based on two directly connected paths
; If there's a direct path from ?begin to ?temp and another from ?temp to ?end,
; an indirect path from ?begin to ?end through ?temp is inferred.
(defrule indirect-path
	(path (nodes $?begin ?temp))     ; Match the first part of the path
	(path (nodes ?temp $?end))       ; Match the continuation of the path
	=>
	(assert (path (nodes $?begin ?temp $?end)))) ; Add the complete indirect path to the fact list

; Rule to print all paths (direct and indirect) 
; It will match any path fact and print the nodes of that path.
(defrule print-paths
	(path (nodes $?nodes))           ; Match any path fact
	=>
	(printout t "Path: " $?nodes crlf)) ; Print the nodes of the matched path

	


	
