%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token IDEN KEYW SEMI NL COMM EQ NUMB

%%

stmt:
    stmt S NL { printf("Valid Declaration\n\n"); printf("Enter the Declaration Statement: "); }
    |
    ;

S:
    KEYW P T
    |
    ;

T: 
    COMM P T
    | SEMI
    ;

P:
    IDEN
    | IDEN EQ IDEN
    | IDEN EQ NUMB
    ;

%%

int yyerror(char *msg)
{
    printf("%s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter the Declaration Statement: ");
    yyparse();
    return 0;
}