type 'a binary_tree = 
	Empty
	| Node of 'a * 'a binary_tree * 'a binary_tree

let make_tree a b c =
	Node(a,b,c)
	
let make_leaf a = 
	Node (a,Empty, Empty)

let give_value a = 
	match a with
	Empty -> failwith "No Value"
	| Node (k , _, _) -> k

let left_child a = 
	match a with
	Empty -> failwith "No left Child"
	| Node (_, k , _) -> k

let right_child a = 
	match a with
	Empty -> failwith "No right Child"
	| Node (_, _, k) -> k

let rec nodes = function
	| Empty -> []
    	| Node(c, l, r) -> nodes l @ (c :: nodes r);;
	
let mem a root = 
	let rec iter a lst = 
		match lst with
		[] -> false
		| h :: t -> if h == a then true else iter a t	 
	in iter a (nodes root) 

let rec is_parent a b root= 
	match root with
	Empty -> false
	| Node(c, l , r) -> if ((c == a) && (((give_value l) == b) || ((give_value r) == b))) then true
				else if ((is_parent a b l) == true ) then true 
				else is_parent a b r	

let rec is_child a b root= 
	match root with
	Empty -> false
	| Node(c, l , r) -> if ((c == b) && (((give_value l) == a) || ((give_value r) == a))) then true
				else if ((is_child a b l) == true ) then true 
				else is_child a b r	

let rec is_ancestor a b root =
	match root with
	Empty -> false 
	| Node(c, l, r) -> if ((c == a) && ( ((mem b l) == true) || ((mem b r) == true))) then true
				else if ((is_ancestor a b l) == true ) then true 
				else is_ancestor a b r
				
let rec is_descendent a b root =
	match root with
	Empty -> false 
	| Node(c, l, r) -> if ((c == b) && ( ((mem a l) == true) || ((mem a r) == true))) then true
				else if ((is_descendent a b l) == true ) then true 
				else is_descendent a b r		
		 			
(*		 	
let a = make_leaf 1;;	    
let c = make_leaf 3;;
let b = make_leaf 2;;
let e = make_leaf 4;;
let f = make_leaf 5;;
let g = make_leaf 6;;
let h = make_leaf 7;;
let t1 = make_tree 4 g h;;
let t2 = make_tree 2 t1 f;;
let t3 = make_tree 1 t2 c;;
*)
