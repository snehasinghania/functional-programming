let hash = Hashtbl.create 10;;

Hashtbl.add hash "Vigyan" "Swimming";;
Hashtbl.add hash "Vigyan" "Skating";;
Hashtbl.add hash "Vigyan" "Cycling";;
Hashtbl.add hash "Janhvi" "Swimming";;
Hashtbl.add hash "Janhvi" "Cycling";;
Hashtbl.add hash "Vedanshi" "Cycling";;
Hashtbl.add hash "Ramnik" "Cycling";;

let inv_hash = Hashtbl.create (Hashtbl.length hash)
let invert hash =
	Hashtbl.iter
	(fun key value ->
		Hashtbl.add inv_hash value key
	)
	hash;;

let print hash = 
	Hashtbl.iter
	(fun key value ->
		Printf.printf "%s - %s\n" key value
	)
	hash;;
	
(*
Hashtbl.find_all nhash "Swimming";; This will give the list in the reverse order of initialization
*)
