%{
    #include <stdio.h>
    #include <stdlib.h>    
%}

%token A B NEWLINE

%%

stmt: 
    stmt S NEWLINE {printf("Valid String\n");}
    |
    ;
S: 
    A S B 
    | A B
    ;

%%

int yyerror(char *msg)
{
    printf("%s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter a string: \n");
    yyparse();
    return 0;
}