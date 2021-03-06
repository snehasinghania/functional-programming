let test_op s =
  let stream : (char Mystream.mystream) = Mystream.string_stream s in
  let rec iter f str =
    let result = f str in
      match result with
        State.Terminate(b) -> s, b
      | State.State(st)    -> iter st ((Mystream.tl str) ())
  in
  iter Op.op stream

let test_ops () =
  let n = ["+"; "-" ; "*" ; ">" ; ">=" ; "<="; "="; "<" ;"==";":=";":";"0"; ">a"; "()"] in
  let result = List.map test_op n in
    List.iter (fun (x, y) -> (Printf.printf "%s -> %b;\n" x y)) result

let _ = test_ops ()
