%{
    #include "y.tab.h"
%}

%%

[a] return A;
[b] return B;
[c] return C;
\n return NL;
[ \t]+ ;
. yyerror("Error");

%%

int yywrap()
{
    return 1;
}