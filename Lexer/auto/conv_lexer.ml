# 1 "conv_lexer.mll"
 
exception Lexer_exception of string

type token =
    Id of string
    | Keyword of string
    | Whitespace of string
	| Newline of string
	| Punctuation of string
	| Operator of string
	| EOF

let correctKeywords = ["int"; "float"; "let"; "rec" ; "if" ; "else"; "then" ; "include" ; "function" ; "fun" ; "type" ; "with" ; "exception" ; "in" ; "as"; "for"; "match"]

# 17 "conv_lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\249\255\250\255\002\000\251\255\252\255\003\000\004\000\
    \001\000\003\000\082\000";
  Lexing.lex_backtrk = 
   "\001\000\255\255\255\255\004\000\255\255\255\255\003\000\003\000\
    \002\000\001\000\000\000";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\000\000\000\000\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\009\000\008\000\008\000\009\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \009\000\000\000\000\000\009\000\000\000\000\000\000\000\000\000\
    \007\000\007\000\004\000\004\000\007\000\007\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\006\000\005\000\003\000\003\000\003\000\004\000\
    \004\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\007\000\000\000\007\000\000\000\007\000\
    \000\000\007\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\008\000\009\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\009\000\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\007\000\007\000\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\000\000\000\000\000\000\000\000\000\000\003\000\
    \006\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\000\000\255\255\007\000\
    \255\255\007\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\010\000\010\000\010\000\
    \010\000\010\000\010\000\010\000\010\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec scan_date lexbuf =
    __ocaml_lex_scan_date_rec lexbuf 0
and __ocaml_lex_scan_date_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 26 "conv_lexer.mll"
         s
# 138 "conv_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 26 "conv_lexer.mll"
           (  if List.mem s correctKeywords then Keyword(s) else Id(s) )
# 142 "conv_lexer.ml"

  | 1 ->
let
# 27 "conv_lexer.mll"
                 s
# 148 "conv_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 27 "conv_lexer.mll"
                   ( Whitespace(s) )
# 152 "conv_lexer.ml"

  | 2 ->
let
# 28 "conv_lexer.mll"
              s
# 158 "conv_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 28 "conv_lexer.mll"
                ( Newline(s) )
# 162 "conv_lexer.ml"

  | 3 ->
let
# 29 "conv_lexer.mll"
                  s
# 168 "conv_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 29 "conv_lexer.mll"
                    ( Punctuation(s) )
# 172 "conv_lexer.ml"

  | 4 ->
let
# 30 "conv_lexer.mll"
               s
# 178 "conv_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 30 "conv_lexer.mll"
                 ( Operator(s) )
# 182 "conv_lexer.ml"

  | 5 ->
# 31 "conv_lexer.mll"
           ( EOF  )
# 187 "conv_lexer.ml"

  | 6 ->
# 32 "conv_lexer.mll"
           ( scan_date lexbuf)
# 192 "conv_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_scan_date_rec lexbuf __ocaml_lex_state

;;

# 35 "conv_lexer.mll"
 
let print_table t =
  (Hashtbl.iter (fun key value -> (Printf.printf "%s %d\n" key !value)) t)

let print_list l p = print_newline (); List.iter p l

let sort_table t =
  let assoc_list = (Hashtbl.fold (fun k v acc -> (k, !v) :: acc) t []) in
    List.sort
      (
        fun (k1, v1) (k2, v2) -> if v1 > v2 then 1 else if v1 < v2 then -1 else 0
      ) assoc_list

let reject_words = ["the"; "is"; "I"; "in"; "on"; "upon"; "between"; "under"; "above"; "over";
  "as"; "at"; "be"; "an"; "a"; "the"; "from"; "to"; "upto"; "am"; "was"; "would"; "could"; "should"; "shall" ]

let reject_words_table =
  let table = Hashtbl.create 30 in
  let rec create_reject_words_table = function
      [] -> table
    | h :: t -> (Hashtbl.add table h ()); create_reject_words_table t
  in
  create_reject_words_table reject_words
 
let keyword_table =
  let table2 = Hashtbl.create 30 in
  let rec create_keyword_table = function
      [] -> table2
    | h :: t -> (Hashtbl.add table2 h ()); create_keyword_table t
  in
  create_keyword_table correctKeywords 
    

let read_all_words () =
	let lexbuf = Lexing.from_channel stdin in
	let rec read_next_word word_list =
	let next_token = (scan_date lexbuf) in
	match next_token with
		Id(s)  ->
			if not (Hashtbl.mem reject_words_table s) && not (Hashtbl.mem keyword_table s) then
				(read_next_word (("Id "^"'"^s^"'") :: word_list))
			else
				read_next_word word_list
		| Keyword(s) -> 
            if not (Hashtbl.mem reject_words_table s) && (Hashtbl.mem keyword_table s) then
              (read_next_word (("Keyword "^"'"^s^"'") :: word_list))
            else
              read_next_word word_list
        | Whitespace(s) -> 
            if not (Hashtbl.mem reject_words_table s) then
              (read_next_word (("Whitespace "^"'"^s^"'") :: word_list))
            else
              read_next_word word_list
        | Newline(s) -> 
            if not (Hashtbl.mem reject_words_table s) then
              (read_next_word (("Newline "^"'"^s^"'") :: word_list))
            else
              read_next_word word_list
        | Punctuation(s) -> 
            if not (Hashtbl.mem reject_words_table s) then
              (read_next_word (("Punctuation "^"'"^s^"'"):: word_list))
            else
              read_next_word word_list
        | Operator(s) -> 
            if not (Hashtbl.mem reject_words_table s) then
              (read_next_word (("Operator "^"'"^s^"'") :: word_list))
            else
              read_next_word word_list      
		| EOF -> word_list

	in
	(List.rev (read_next_word []))

let make_table word_list =
  let table = Hashtbl.create 30 in
  let rec enter_word = function
      h :: t ->
        if Hashtbl.mem table h then
          let count = Hashtbl.find table h in count := !count + 1
        else 
          Hashtbl.add table h (ref 1);
          enter_word t
    | [] -> ()
  in
  enter_word word_list;
  table

let main () =
  let word_list = read_all_words () in
  let table = make_table word_list
  in
  (* print_table table; *)
  let sorted = (sort_table table) in
    (print_list sorted (fun (k, v) -> (Printf.printf "%s -> %d\n" k v)))
  ;;

main ()

# 297 "conv_lexer.ml"
