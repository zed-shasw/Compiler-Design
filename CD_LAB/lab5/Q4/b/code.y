%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token A B C NL 

%%

expr: 
    expr S NL { printf("Valid String\n"); }
    |
    ;
S: 
    A S B
    | B S A
    | C 
    ;

%%

int yyerror(char *msg)
{
    printf("Invalid String\n");
    return 1;
}

int main()
{
    printf("Enter a string:\n");
    yyparse();
    return 0;
}
