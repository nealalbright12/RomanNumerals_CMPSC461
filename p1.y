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
%token T_LINE

%token T_C T_Y T_R T_E T_H T_TEST // You need to define your tokens from flex here.
				  // op, decimalPoint, huns, tens, ones
				  // frac, wholenum?
%type<fval> Num
%start Expr

%%

Expr: Var
     |Var Op Var
;

Var: Num
     |Num.Num
     |.Num
;

Num: Ones
     |Tens
     |Hundreds
;



YOURGRAMMAR: SOMETHINGELSE
	| //Epsilon

SOMETHINGELSE: T_TEST { printf("This part is the attribute grammar of your CFG"); }

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
