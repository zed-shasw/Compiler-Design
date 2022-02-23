%{
    #include <stdio.h>
    int words = 0;
%}

W [^( \t\n)]
S [ \n\t\(\)]

%%

{S} ;
{W}* { if(yyleng >= 5 && yyleng <=10) words++; }

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
    printf("Number of matched words: %d\n", words);
    return 0;
}

int yywrap()
{
    return 1;
}