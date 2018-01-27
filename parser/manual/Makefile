rdparser : lexer.cmx 
	ocamlopt str.cmxa lexer.cmx rdparser.ml -o rdparser

lexer.cmx : lexer.ml
	ocamlopt -c lexer.ml

lexer.cmi : lexer.ml 
	ocamlopt -c lexer.ml

lexer.ml : lexer.mll
	ocamllex lexer.mll

clean:
	rm *.cm[ix] lexer.ml *.o rdparser a.out
