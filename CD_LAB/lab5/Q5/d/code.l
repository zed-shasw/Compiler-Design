%{
    #include "y.tab.h"
    #include <string.h>

    char charSet[100][100];
    int charSetLen = 0;

    int check(char *text)
    {
        for(int i=0; i<charSetLen; i++)
        {
            if(strcmp(charSet[i], text) == 0) 
                return 1;
        }
        strcpy(charSet[charSetLen], text);
        charSetLen++;
        return 0;
    }
%}

L [A-Za-z]
D [0-9]

%%

{L}({L}|{D})* { if(check(yytext)){ yyerror("syntax error"); } return IDEN; }
{D}+"."{D}* return FLOA;
{D}+ return NUMB;
"=" return ASSI;
";" return SEMI;
\n { charSetLen = 0; return NEWL; }
[ \t] ;
. yyerror("syntax error");

%%

int yywrap()
{
    return 1;
}