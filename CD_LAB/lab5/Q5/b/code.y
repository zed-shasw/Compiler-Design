%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token INT NEW ADD SUB MUL DIV OPE CLO
%left ADD SUB 
%left MUL DIV

%%

stmt:
    stmt expr NEW { printf("Result: %d\n", $2); }
    |
    ;

expr:
    INT { $$ = $1; }
    | expr DIV expr { if($3 == 0){ yyerror("Divide by 0"); } $$ = $1 / $3; }
    | expr MUL expr { $$ = $1 * $3; }
    | expr ADD expr { $$ = $1 + $3; }
    | expr SUB expr { $$ = $1 - $3; }
    | OPE expr CLO { $$ = $2; }
    ;

%%

int yyerror(char *msg)
{
    printf("%s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter an arithmetic operation:\n");
    yyparse();
    return 0;
}