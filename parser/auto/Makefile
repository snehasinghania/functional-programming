parser : lexer.cmx parser.cmx main.cmx
	ocamlopt -o parser lexer.cmx parser.cmx str.cmxa main.cmx

lexer.cmx : parser.cmi lexer.ml
	ocamlopt -c lexer.ml

lexer.cmi : parser.cmi lexer.ml
	ocamlopt -c lexer.ml

lexer.ml : lexer.mll
	ocamllex lexer.mll

parser.ml : parser.mly
	ocamlyacc parser.mly

parser.cmi : parser.mli
	ocamlc -c parser.mli

parser.mli : parser.mly
	ocamlyacc parser.mly

parser.cmx : lexer.cmi parser.ml
	ocamlopt -c parser.ml

main.cmx : parser.cmi lexer.cmi main.ml
	ocamlopt -c main.ml

clean:
	rm *.cm[ix] lexer.ml *.o parser a.out
