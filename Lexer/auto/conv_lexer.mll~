{
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
}


let digit = ['0'-'9']
let integer = ['0'-'9']['0'-'9']*
let id = ['a'-'z''A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9']*
let whitespace = [' ' '\t']*
let newline = ['\n']*
let punctuation = ['(' ')' '{' '}']* | [';' ':']
let operator = ['+' '*' ] | ['>' '<' '=' ':']['='] | ['>' '<' '=' ':']

rule scan_date = parse
	| id as s {  if List.mem s correctKeywords then Keyword(s) else Id(s) }
	| whitespace as s { Whitespace(s) }
	| newline as s { Newline(s) }
	| punctuation as s { Punctuation(s) }
	| operator as s { Operator(s) }
	| eof     { EOF  }
	| _       { scan_date lexbuf}


{
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
}
