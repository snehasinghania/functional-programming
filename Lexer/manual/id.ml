(*
  The following scanner implements the scanner to scan identifiers. For example:
  - Valid inputs: "A"; "Aa"; "AaA"; "A1"; "Aa1"; "A1a"; "a1"; "a_"; "_a"; "a_a"
  - Invalid inputs: "1a"; "_1ab" ; "__a"; more than one underscore is invalid

The FSA is

	A --- input = '_' ---> C --- input = 'a' ---> D (accept with letter or number loop)
	'                                             ^
     input = letter                                   '	
	'                                             '      
       	B ------------ input = '_' ------------------->
     accept state with letter and number loop  		
  
  Please see test_id.ml to see how this scanner is used.
*)

let id (s : char Mystream.mystream) : State.state =
	let rec one (stream : char Mystream.mystream) : State.state =
		match stream with
		Mystream.End -> State.Terminate(false)
		| Mystream.Cons(c, _) ->
			let lookahead = (Mystream.tl stream) () in
				if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') then   (*This is staring with letter*)
					match lookahead with
					Mystream.Cons(c', _) -> 
					if (c' >= 'A' && c' <= 'Z') || (c' >= 'a' && c' <= 'z')  || (c' >= '0' && c' <= '9') then     
						State.State(three) 
					else
						State.Terminate(true) 
					| Mystream.End -> State.Terminate(true)

				else if  c = '_' then (*This is starting with _*)
					State.State(two)
				else
					State.Terminate(false)

and two  (stream : char Mystream.mystream) : State.state =
	match stream with
	Mystream.End -> State.Terminate(false) (*This is only _*)
	| Mystream.Cons(c, _) ->
		let lookahead = (Mystream.tl stream) () in
			if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') then
				match lookahead with
				Mystream.Cons(c', _) -> 
				if (c' >= 'A' && c' <= 'Z') || (c' >= 'a' && c' <= 'z')  || (c' >= '0' && c' <= '9') then     
					State.State(four)
				else
					State.Terminate(true)
				| Mystream.End -> State.Terminate(true)
			else
				State.Terminate(false)
				
and three  (stream : char Mystream.mystream) : State.state =
	match stream with
	Mystream.End -> State.Terminate(true) (*This is only single letter*)
	| Mystream.Cons(c, _) ->
		let lookahead = (Mystream.tl stream) () in
			if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9')then
				match lookahead with
				Mystream.Cons(c', _) -> 
				if (c' >= 'A' && c' <= 'Z') || (c' >= 'a' && c' <= 'z')  || (c' >= '0' && c' <= '9') then     
					State.State(three)
				else if c' = '_' then
					State.State(four)
				else
					State.Terminate(true)
				| Mystream.End -> State.Terminate(true)
			else if c = '_' then
				State.State(four)
			else
				State.Terminate(true)				
and four (stream : char Mystream.mystream) : State.state =
    match stream with
      Mystream.End -> State.Terminate(true) (*This is the final accept state*)
    | Mystream.Cons(c, _) ->
        let lookahead = (Mystream.tl stream) () in
        if (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') then
           match lookahead with
            Mystream.Cons(c', _) ->
              if (c' >= 'A' && c' <= 'Z') || (c' >= 'a' && c' <= 'z')  || (c' >= '0' && c' <= '9') then     
                State.State(four)
              else
                State.Terminate(true)
          | Mystream.End -> State.Terminate(true)
      else
        State.Terminate(true)
in
match s with
	Mystream.End -> State.Terminate(false)
    | _ -> one s	

