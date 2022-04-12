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

L [a-zA-Z]
D [0-9]

%%

"int"|"float"|"char"|"double"|"long"|"long long"|"long long int"|"auto"|"long double" return KEYW;
{L}({L}|{D})* { if(check(yytext)){ yyerror("syntax error"); } return IDEN; }
{D}+|("-"{D}+) return NUMB;
"=" return EQ;
";" return SEMI;
"," return COMM;
[ \t]+ ;
\n { charSetLen = 0; return NL; }
. yyerror("syntax error");

%%

int yywrap()
{
    return 1;
}