%{
    #include <stdio.h>
    #include <stdlib.h>
%}

B [b]
A [a]
O [^( \t\n)]

%%

{B}*({A}{B}*{A}{B}*)* printf("%s : Following\t", yytext);
[ \t] ;
{O}* printf("%s : Not Following\t", yytext);

%%

int main() 
{
    yylex();
    return 0;
}

int yywrap() 
{
    return 1;
}
