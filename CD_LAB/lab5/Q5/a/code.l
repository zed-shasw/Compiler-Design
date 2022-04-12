%{
    #include "y.tab.h"
%}

D [0-9]
L [A-Za-z]

%%

{D}|{L} { yylval = *yytext; return KEY; }
[ \t]* ;
\n return NL;
"+"|"-"|"*"|"/" { yylval = *yytext; return OP; }
"(" return PO;
")" return PC;
. yyerror("Syntax Error");

%%

int yywrap()
{
    return 0;
}