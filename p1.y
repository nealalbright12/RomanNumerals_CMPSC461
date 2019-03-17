%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>


extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union{
  float fval;
  
}

%token<fval> T_FLOAT
%token T_PLUS T_MINUS T_TIMES T_DIVIDE
%token T_LINE T_POINT

//%token T_C T_Y T_R T_E T_H T_TEST // You need to define your tokens from flex here.
//				  // op, decimalPoint, huns, tens, ones
//				  // frac, wholenum?

%type<fval> Num
%start Input        // changed Expr to Input, for multi-line functionality

%%
// Input is all the exressions to be read
Input: // Epsilon    
     | Expr Input   { printf("Result: %f\n", $1); }
;

Expr: Var T_LINE
    | Var T_PLUS Var T_LINE   { $$ = $1 + $3; }
    | Var T_MINUS Var T_LINE  { $$ = $1 - $3; }
    | Var T_TIMES Var T_LINE  { $$ = $1 * $3; }
    | Var T_DIVIDE Var T_LINE { $$ = $1 / $3; }
;

Var: Num       { $$ = $1 }
   | Num T_POINT Frac    { $$ = $1 + $3 }
   | T_POINT Frac        { $$ = $2 }
;

Num: Ones                { $$ = $1 }
   | Tens Ones           { $$ = $1 + $2 }
   | Hundreds Tens Ones  { $$ = $1 + $2 + $3 }
;

Frac: Ones               { $$ = ($1)/10
    | Tens Ones          { $$ = ($1 + $2) / 100 }
    | Hundreds Tens Ones { $$ = ($1 + $2 + $3) / 1000 }
;

Hundreds: // Epsilon
	| T_C T_C T_C    { $$ = 300 }
	| T_C T_C        { $$ = 200 }
	| T_C            { $$ = 100 }
;	

Tens: // Epsilon
    | T_L T_X T_X T_X    { $$ = 80 }
    | T_L T_X T_X        { $$ = 70 }
    | T_L T_X            { $$ = 60 }
    | T_X T_C		 { $$ = 90 }
    | T_X T_L		 { $$ = 40 }
    | ////****** LEFT OFF HERE ******////

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
