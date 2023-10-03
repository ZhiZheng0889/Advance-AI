; CLIPS Exercise 1
; Student Name: xxx
; Purpose: Find the routing table of the following network:
; There is a directional link from A to B
; There is a directional link from B to C
; ...

(deftemplate link
  (slot from)
  (slot to))
  
(deffacts paths
	(link (from A) (to B))
	(link (from B) (to C))
	(link (from B) (to D))
	(link (from D) (to E))
	(link (from E) (to F)))

(defrule infer-indirect-paths
	(link (from ?begin) (to ?temp))
	(link (from ?temp) (to ?end))
	=>
	(assert (link (from ?begin) (to ?end))))
	
(defrule print-all-paths
	(link (from ?begin) (to ?end))
	=>
	(printout t "There is a path from " ?begin " to " ?end crlf))



