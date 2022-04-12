%{
    #include "y.tab.h"
%}

%%

[a] return A;
[b] return B;
[ \t] ;
\n return NEWLINE;
. yyerror("syntax error (lex)");

%%

int yywrap() 
{
    return 1;
}


