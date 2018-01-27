(*
  The following scanner implements the scanner to scan identifiers. For example:
  - Valid inputs: "+"; "-"; "*"; "<"; ">"; "="; "<="; ">="; "==" ; ":="
  - Invalid inputs: alphabet ; numuber ;  any other special character are invalid

  Please see test_op.ml to see how this scanner is used.
*)

let op (s : char Mystream.mystream) : State.state =
	let rec one (stream : char Mystream.mystream) : State.state =
		match stream with
		Mystream.End -> State.Terminate(false)
		| Mystream.Cons(c, _) ->
			let lookahead = (Mystream.tl stream) () in
				if (c = '+') || (c = '-') || c = '*'then
					State.Terminate(true) 
				else if c = '<' || c = '>' || c = '=' then
					match lookahead with
					Mystream.Cons(c', _) ->
					if c' = '=' then (* This is >= , == or <= *)
						State.State(two) 
					else
						State.Terminate(true) (* This is only < , = or > *)
					| Mystream.End ->
						State.Terminate(true)	
				else if c = ':' then
					match lookahead with
					Mystream.Cons(c', _) ->
					if c' = '=' then (* This is := *)
						State.Terminate(true)
					else 
						State.Terminate(false) (*If only : is given as input*)
					| Mystream.End ->
						State.Terminate(false)
				else
					State.Terminate(false)

and two  (stream : char Mystream.mystream) : State.state =
	match stream with
      Mystream.End -> State.Terminate(true) (*This is the final accept state*)
    | Mystream.Cons(c, _) ->
        if c = '=' then
			State.Terminate(true)
      	else
        	State.Terminate(false)
in
match s with
Mystream.End -> State.Terminate(false)
| _ -> one s

