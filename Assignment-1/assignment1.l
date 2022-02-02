%{
    #include <stdio.h>
    #include <stdlib.h>
%}

A [a]
B [b-z]

%%

{B}*({A}{B}*{A}{B}*)* printf("Following\n");
{B}*{A}{B}*({A}{B}*{A}{B}*)* printf("Not Following\n");

%%

int yywrap() { }
   
int main()
 { 
  yylex();
  return 0;
 }
