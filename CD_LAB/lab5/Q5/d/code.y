%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token NUMB ASSI NEWL IDEN FLOA SEMI

%%

stmt: 
    stmt IDEN S NEWL { printf("Valid Assignment Operation\n\n"); printf("Enter the assignment statement: "); }
    |
    ;

S:
    ASSI IDEN S
    | ASSI FLOA SEMI
    | ASSI NUMB SEMI
    | SEMI
    ;

%%

int yyerror(char *msg)
{
    printf("%s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter the assignment statement: ");
    yyparse();
    return 0;
}