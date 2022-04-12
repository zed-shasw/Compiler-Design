%{
    #include "y.tab.h"
    extern int yylval;
%}

%%

[0-9]+ { yylval = atoi(yytext); return INT; }
\n return NEW;
[ \t]+ ;
"+" return ADD;
"-" return SUB;
"*" return MUL;
"/" return DIV;
"(" return OPE;
")" return CLO;
. yyerror("Invalid Character");

%%

int yywrap()
{
    return 1;
}
