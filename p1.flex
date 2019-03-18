%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "p1.tab.h"

%}

%%
"I" {return T_I;}   
"V" {return T_V;}   
"X" {return T_X;}   
"L" {return T_L;}   
"C" {return T_C;}
"." {return T_POINT;}
"+" {return T_PLUS;}
"-" {return T_MINUS;}
"*" {return T_TIMES;}
"/" {return T_DIVIDE;}
\n  {return T_LINE;}
%%
