let test_space_newline s =
  let stream : (char Mystream.mystream) = Mystream.string_stream s in
  let rec iter f str =
    let result = f str in
      match result with
        State.Terminate(b) -> s, b
      | State.State(st)    -> iter st ((Mystream.tl str) ())
  in
  iter Space_newline.space_newline stream

let test_spaces () =
  let n = [" "; "  " ; "		" ; "\n" ; "	\n" ; "    "; "\n 	"; " 	" ] in
  let result = List.map test_space_newline n in
    List.iter (fun (x, y) -> (Printf.printf "%s -> %b;\n" x y)) result

let _ = test_spaces ()
