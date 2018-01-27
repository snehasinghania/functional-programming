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

let rec mem x = function  
	Empty -> false
  	| Node (value, left , right) ->
    		if x < value then mem x left
    		else if x = value then true
    		else mem x right
 

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
		 			
let rec add a root =
	match root with   
	Empty -> Node (a, Empty, Empty) 
  	| Node (value, left, right) -> if a < value then Node (value, add a left, right) 
    					else Node (value, left, add a right) 

let rec max l = 
	match l with
	Empty -> failwith "No value"
	| Node(value, Empty, Empty) -> l
	| Node(value, left , _) -> max left

let rec delete k = function
	| Empty -> raise Not_found
	| Node (v, l, r) ->
	if k < v then Node (v, (delete k l),r)
	else if k > v then Node (v, l, (delete k r))
	else 
		match (l, r) with
		| (Empty, Empty) -> Empty
		| (l, Empty) -> l
		| (Empty, r) -> r
		| (_, _) ->
		let Node (vl, _, _) = max l in
			Node (vl, (delete vl l), Empty)


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
