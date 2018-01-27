%{
%}

%token ADD SUB MUL DIV EOF EQL
%token <int> NUM
%token <string> ID
%start input_eqn
%type <bool> input_eqn

%% /* Grammar rules and actions follow */
;
  input_eqn : ID EQL expr {true && $3}
   	
  expr  : term EOF        { $1       }

  term  : factor          { $1       }
        | factor ADD term { $1 && $3 }

  factor: NUM             { true       }
  	| ID		  { true       }	
        | NUM MUL factor  { true && $3 }
        | ID MUL factor  { true && $3 } 
        | NUM SUB factor  { true && $3 }
        | ID SUB factor  { true && $3 } 
        | NUM DIV factor  { true && $3 }
        | ID DIV factor  { true && $3 } 
;

%%

(*
Context free grammar

eqn:	Id '=' expr ;

expr  : term

  term  : factor          
        | factor ADD term  

  factor: NUM              
        | NUM * factor
        | Id
        | Id * factor
;*)
