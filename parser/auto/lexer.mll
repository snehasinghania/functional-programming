{
exception Lexer_exception of string
}

let digit = ['0'-'9']
let integer = ['0'-'9']['0'-'9']*
let id = ['a'-'z''A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9']*

rule scan = parse
  | integer as s {  Parser.NUM(int_of_string s) }
  | id as s {  Parser.ID(s) }
  | "+"  { Parser.ADD  }
  | "*"  { Parser.MUL }
  | "-"  { Parser.SUB }
  | "/"  { Parser.DIV } 
  | "="  { Parser.EQL } 
  | eof  { Parser.EOF  }
  | _    { scan lexbuf }


{
}
