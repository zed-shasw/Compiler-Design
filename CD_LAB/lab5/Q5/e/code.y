%{
    #include <stdio.h>
    #include <stdlib.h>
%}

%token IDEN NUMB SEMI COMM AO LO RO BO PO PC UU BU EQ NL LOOP LNOT KEY
%left BO
%left RO
%left AO

%%

stmt:
    stmt expr NL { printf("for Loop Detected\n\nEnter the statement: "); }
    |
    ;

expr:
    LOOP PO S PC W
    ;

W: 
    SEMI
    |
    ;

S:
    I SEMI C SEMI U
    ;

I:
    KEY V T
    | V T
    |
    ;

T: 
    COMM V T
    |
    ;

V:
    IDEN
    | IDEN EQ IDEN
    | IDEN EQ NUMB
    ;

C:
    cond
    | PO cond PC
    | cond LO cond
    | LNOT cond
    |
    ;

cond:
    aexpr RO aexpr
    ;

aexpr:
    PO aexpr PC
    | aexpr AO aexpr
    | aexpr BO aexpr
    | F
    ;

F:
    NUMB
    | IDEN
    ;

U: UU cont
    | IDEN BU IDEN cont
    | IDEN BU NUMB cont
    |
    ;

cont: COMM UU cont
    | COMM IDEN BU IDEN cont
    | COMM IDEN BU NUMB cont
    |
    ;

%%

int yyerror(char *msg)
{
    printf("%s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter the statement: ");
    yyparse();
    return 0;
}