type token =
  | ADD
  | SUB
  | MUL
  | DIV
  | EOF
  | EQL
  | NUM of (int)
  | ID of (string)

val input_eqn :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> bool
