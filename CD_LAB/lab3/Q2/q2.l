%{
    #include <stdio.h>

    int iden=0, cons=0, oper=0;
%}

O "*"|"+"|"/"|"-"|"++"|"--"
L [A-Za-z]
D [0-9]
I [ \t\n]

%%

{I} ;
"(" printf("Opening Parenthesis: %s\n", yytext);
")" printf("Closing Parenthesis: %s\n", yytext);
({L}|"_")({L}|{D}|"_")* printf("Identidfier: %s\n", yytext), iden++;
{D}*|({D}*"."{D}*) printf("Constant: %s\n", yytext), cons++;
{O} printf("Operator: %s\n", yytext), oper++;

%%

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        printf("Syntax : %s <FILE_NAME>\n", argv[0]);
        exit(1);
    }
    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL)
    {
        printf("ERR: FILE NOT FOUND\n");
        exit(2);
    }
    yyin = fp;
    yylex();
    printf("\nNumber of identifiers: %d\nNumber of operators: %d\nNumber of constants: %d\n\n", iden, oper, cons);
    return 0;
}

int yywrap()
{
    return 1;
}
