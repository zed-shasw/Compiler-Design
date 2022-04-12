%{
    #include <stdio.h>
    int line = 1;

    void gotKeyword(int l, char *text)
    {
        int len = strlen(text);
        printf("Line %d : ", l);
        for(int i=0; i<len; i++)
        {
            printf("%c", text[i]-32);
        }
        printf("\n");
        return;
    }
%}

E [^( \t\n)]
W [ \t]
L [A-Za-z]
S [0-9]
Q [^"]
N [0-9]+
D [0-9]+"."[0-9]+
K "int"|"float"|"double"|"long"|"for"|"while"|"do"|"begin"|"goto"|"return"|"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"else"|"enum"|"extern"|"if"|"register"|"short"|"signed"|"unsigned"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"void"|"volatile"|"printf"|"main"|"scanf"|"malloc"|"calloc"|"realloc"

%%

{W}* ;
{K} gotKeyword(line, yytext);
\n line++;
\'.\' printf("Line %d : CHAR_CONSTANT %s\n", line, yytext);
\"{Q}*\" printf("Line %d : STRING_CONSTANT %s\n", line, yytext);
{N}|("-"{N}) printf("Line %d : NUMBER %s\n", line, yytext);
{D}|("-"{D}) printf("Line %d : REAL_NUMBER %s\n", line, yytext);
({D}|{N}|("-"{D})|("-"{N}))"e"({D}|{N}|("-"{D})|("-"{N})) printf("Line %d : EXP_NUMBER %s\n", line, yytext);
{L}({L}|{S})* printf("Line %d : IDENTIFIER %s\n", line, yytext);
"{" printf("Line %d : OPENCURLY\n", line);
"}" printf("Line %d : CLOSEDCURLY\n", line);
\( printf("Line %d : OPENPAREN\n", line);
\) printf("Line %d : CLOSEDPAREN\n", line);
\? printf("Line %d : QUESMARK\n", line);
\[ printf("Line %d : OPENSQBRAC\n", line);
\] printf("Line %d : CLOSEDSQBRAC\n", line);
"#" printf("Line %d : SHARP\n", line);
"$" printf("Line %d : POUND\n", line);
"&" printf("Line %d : BIT_AND\n", line);
"~" printf("Line %d : TILDE\n", line);
"|" printf("Line %d : BIT_OR\n", line);
"^" printf("Line %d : BIT_XOR\n", line);
"&&" printf("Line %d : LOG_AND\n", line);
"||" printf("Line %d : LOG_OR\n", line);
"!" printf("Line %d : LOG_NOT\n", line);
">" printf("Line %d : GT\n", line);
">=" printf("Line %d : GE\n", line);
"==" printf("Line %d : EQ\n", line);
"!=" printf("Line %d : NE\n", line);
"<" printf("Line %d : LT\n", line);
"<=" printf("Line %d : LE\n", line);
"." printf("Line %d : DOT\n", line);
\= printf("Line %d : ASSGN\n", line);
";" printf("Line %d : ENDLINE\n", line); 
\+ printf("Line %d : ADD\n", line);
\- printf("Line %d : SUB\n", line);
\* printf("Line %d : MULT\n", line);
"/" printf("Line %d : DIV\n", line);
"++" printf("Line %d : INC\n", line);
"--" printf("Line %d : DCR\n", line);
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
    fclose(fp);
    return 0;
}

int yywrap()
{
    return 1;
}
