type 'a mystream =
    Empty
  | Cons of 'a * (unit -> 'a mystream)


let hd = function
    Empty -> failwith "empty"
  | Cons(h, _) -> h

let tl = function
    Empty -> failwith "empty"
  | Cons(_, t) -> t

let rec ns n = 
	Cons(n, fun () -> ns n)

let rec natural_numbers n = 
	Cons(n, fun () -> natural_numbers (n+1))

let rec even_num n = 
	Cons(n, fun () -> even_num (n+2))

let rec odd_num n = 
	Cons(n, fun () -> odd_num (n+2))

let rec fibo a b = 
	Cons(a, fun () -> fibo b (a + b) )
