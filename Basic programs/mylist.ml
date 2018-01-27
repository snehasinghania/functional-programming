type 'a mylist =
    Empty_list
  | Cons of 'a * ('a mylist)


let hd = function
    Empty_list -> failwith "empty"
  | Cons(h, _) -> h

let tl = function
    Empty_list -> failwith "empty"
  | Cons(_, t) -> t

let length a = 
	let rec iter a n = 
		if a == Empty_list then n 
		else iter (tl a) (n+1) 
	in iter a 0

let rec nth a (n : int) =
	if n = 1 then hd a
	else nth (tl a) (n-1)
	
let rec append a b = 
	if a == Empty_list then Cons(b, Empty_list)
	else Cons(hd a, append (tl a) b)
	
let rev a =
	let rec iter a n =
		if n < 0 then Empty_list
		else Cons((nth a n) , iter a (n-1))
	in iter a ((length a) - 1)
