%{
    #include <stdio.h>
%}

O "*"|"+"|"/"|"-"|"++"|"--"
L [A-Za-z]
D [0-9]
I [ \t\n]

%%

{I} ;
"(" printf("Opening Parenthesis: %s\n", yytext);
")" printf("Closing Parenthesis: %s\n", yytext);
({L}|"_")({L}|{D}|"_")* printf("Identidfier: %s\n", yytext);
{D}*|({D}*"."{D}*) printf("Constant: %s\n", yytext);
{O} printf("Operator: %s\n", yytext);

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
    return 0;
}

int yywrap()
{
    return 1;
}
