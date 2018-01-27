(*
  The following scanner implements the scanner to scan identifiers. For example:
  - Valid inputs: "\n"; "\t"; " "
  - Invalid inputs: alphabet ; numuber ;  any other special character are invalid

  Please see test_space_newline.ml to see how this scanner is used.
*)

let space_newline (s : char Mystream.mystream) : State.state =
	let rec one (stream : char Mystream.mystream) : State.state =
		match stream with
		Mystream.End -> State.Terminate(true) 
		    | Mystream.Cons(c, _) ->
			let lookahead = (Mystream.tl stream) () in
			if (c = ' ' || c = '\t' || c = '\n') then
			   match lookahead with
			    Mystream.Cons(c', _) ->
			      if (c = ' ' || c = '\t' || c = '\n') then     
				State.State(one)
			      else
				State.Terminate(true)
			  | Mystream.End -> State.Terminate(true)
		      else
			State.Terminate(true)
in
match s with
Mystream.End -> State.Terminate(false)
| _ -> one s

