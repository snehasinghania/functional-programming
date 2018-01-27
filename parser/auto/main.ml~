let tss = [
  "a = 10; h = 9; v = vv / i * ;"        ;
  "a  = b + 20"    ;
  "c = d - 6";
  "1 + 2 + " ; (* <error> *)
  "x = y / 2" ;
  "1 + 2 * 3";
  "1 * 2 + 3";
  "1 2"      ; (* <error> *)
  "1 * 2 + " ; (* <error> *)
  "1 + 2 * " ; (* <error> *)
]

let split str = Str.split(Str.regexp "[;]") str
let caliter s = let l = split s in List.iter test_rdparser l

let test_rdparser s =
  try
    let lexbuf = Lexing.from_string s in
    let result = (Parser.input_eqn Lexer.scan lexbuf) in
    Printf.printf "%s -> %b\n" s result
  with Parsing.Parse_error ->
    Printf.printf "%s -> false\n" s

let test_all () =
  let rec iter = function
      [] -> ()
    | h :: t -> (caliter h); (iter t)
  in
  iter tss

let _ = test_all ()

