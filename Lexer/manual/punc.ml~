(*
  The following scanner implements the scanner to scan identifiers. For example:
  - Valid inputs: "()" , "{}" , ";", ":"
  - Invalid inputs: alphabet ; numuber ;  any other special character are invalid

  Please see test_op.ml to see how this scanner is used.

checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk
*)


let stack1 = ref [];;
let stack2 = ref [];;
let empty = ref [];;

let punc (s : char Mystream.mystream) : State.state =
	let rec one (stream : char Mystream.mystream) : State.state =
		match stream with
		| Mystream.Cons(c, _) ->
			if c = ')' || c = '(' || c = ';' || c = ':' || c = '{' || c = '}' then
				State.Terminate(true)
			else
				State.State(one)
		| Mystream.End -> State.Terminate(false)				
in
match s with
	Mystream.End -> State.Terminate(false)
    | _ -> one s
