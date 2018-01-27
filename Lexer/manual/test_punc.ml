let test_punc s =
  let stream : (char Mystream.mystream) = Mystream.string_stream s in
  let rec iter f str =
    let result = f str in
      match result with
        State.Terminate(b) -> s, b
      | State.State(st)    -> iter st ((Mystream.tl str) ())
  in
  iter Punc.punc stream

let test_puncs () =
  let n = ["()"; "(ab(c))" ; "{}" ; "{ab}b" ; ";" ; ":"; "{" ; "{{}" ; "((())"] in
  let result = List.map test_punc n in
    List.iter (fun (x, y) -> (Printf.printf "%s -> %b;\n" x y)) result

let _ = test_puncs ()
