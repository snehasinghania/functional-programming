let hash = Hashtbl.create 10;; 
let freq str =
	for n = 0 to (String.length str - 1) do 
		Hashtbl.replace hash str.[n] 0
	done;
	for n = 0 to (String.length str - 1) do 
		Hashtbl.replace hash str.[n] ((Hashtbl.find hash str.[n]) + 1)
	done

let print hash= 
	Hashtbl.iter
	(fun key value ->
		Printf.printf "%c - %d\n" key value
	)
	hash;;
	
let convert h =
	Hashtbl.fold (fun k v acc -> (k,v) :: acc ) h [] 

let rec sort a =
	match a with
	[] -> []
	| h :: t -> insert h (sort t)
and insert (p,q) a =
	match a with
	[] -> [(p,q)]
	| (key,value) :: t -> if q >= value then (p,q) :: a 
				else (key,value) :: insert (p,q) t;;
   
let sort_words l h =
	let rec iter l = 
		match l with
		[] -> []
		| h :: t -> (fst h) :: iter t
	in iter (sort (convert h))
				
