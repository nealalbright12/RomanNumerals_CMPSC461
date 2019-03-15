%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "p1.tab.h"

%}

%%
"CREATE" {return T_C;}   
"YOUR" {return T_Y;}   
"REGULAR" {return T_R;}   
"EXPRESSIONS" {return T_E;}   
"HERE" {return T_H;}
"CMPSC461" {return T_TEST;}
%%