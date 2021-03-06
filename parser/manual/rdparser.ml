type expr =
    Num      of int
  | Id       of string
  | Add      of expr * expr
  | Sub of expr * expr
  | Mult of expr * expr
  | Div  of expr * expr
  | Paren    of expr

(*
Context free grammar

input_eqn:    Id EQL expr ;

expr  : term

  term  : factor          
        | factor ADD term

  factor: NUM              
        | NUM MUL factor
        | NUM  SUB factor
        | NUM DIV factor
        | Id
        | Id MUL factor
        | ID  SUB factor
        | Id DIV factor
;*)

(*
Left Factored Grammar:

  input_eqn  :  Id EQL expr ;
 
  expr    : term

  term    : factor term'

  term'   : EOF
          | ADD term
          

  factor  : NUM factor'| Id factor'

  factor' : EOF
  	  | SUB term	
          | MUL factor
          | DIV factor
*)

let next_token = ref Lexer.EOF

let expect (tok : Lexer.token) =
  match tok with
   Lexer.ID(_) ->
    (
      match !next_token with
        Lexer.ID(_) -> true
      | _ -> false
    )
   |Lexer.NUM(_) ->
    (
      match !next_token with
        Lexer.NUM(_) -> true
      | _ -> false
    )
  | _ -> tok = !next_token

let consume lexbuf =
  next_token := Lexer.scan lexbuf

    
let input_eqn lexbuf =
    consume lexbuf;
    if(expect (Lexer.ID("abc"))) = false then false
    else
    begin
        consume lexbuf;
        if(expect Lexer.EQL) = false then false
        else
            expr lexbuf
    end

and expr lexbuf =
  consume lexbuf;
  term lexbuf

and term lexbuf =
    if (factor lexbuf) = false then false
    else
    begin
      term' lexbuf
    end

and term' lexbuf =
  if (expect Lexer.EOF) then true
  else if (expect Lexer.ADD) then
  begin
    consume lexbuf;
    term lexbuf
  end
  else false

and factor lexbuf =
  if (expect (Lexer.NUM(1))) then
  begin
    consume lexbuf;
    factor' lexbuf
  end
  else if(expect (Lexer.ID("abc"))) then
  begin
      consume lexbuf;
      factor' lexbuf
  end
  else false

and factor' lexbuf =
  if (expect Lexer.EOF) then true
  else if ((expect Lexer.MUL)||(expect Lexer.DIV)||expect Lexer.SUB) then
  begin
    consume lexbuf;
    factor lexbuf
  end
  else if (expect Lexer.ADD)then true
  else false

let tss = [
  "a = d - 6; b = a * 4;c = 8;";
  "b = a * 2; cc = asgag / asdgmsg";
  "1 + 2 + 3";
  "1 + 2 + " ; (* <error> *)
  "1 * 2"    ;
  "1 + 2 * 3";
  "1 * 2 + 3";
  "1 2"      ; (* <error> *)
  "1 * 2 + " ; (* <error> *)
  "1 + 2 * " ; (* <error> *)
]
let split str = Str.split(Str.regexp "[;]") str


let test_rdparser s =
  let lexbuf = Lexing.from_string s in
  Printf.printf "%s -> %b\n" s (input_eqn lexbuf)
  
let test_iter h =
    let lst = split h in
    List.iter test_rdparser lst
let test_all () =
  let rec iter = function
      [] -> ()
    | h :: t -> (test_iter h); (iter t)
  in
  iter tss

let _ = test_all ()
