%{
    #include <stdio.h>
    #include <stdlib.h>

    int flag = 0;
%}

B [b-z]
A [a]

%%

{B}*({A}{B}*{A}{B}*)* printf("Following\n");
{B}*{A}{B}*({A}{B}*{A}{B}*)* printf("Not Following\n");

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
