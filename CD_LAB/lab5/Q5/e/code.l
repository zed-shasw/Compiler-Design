%{
    #include "y.tab.h"
    #include <string.h>

    char charSet[100][100];
    int charSetLen = 0;
    int flag = 1;

    int check(char *text)
    {
        if(flag == 0)
        {
            return 0;
        }
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

F "for"
K "int"|"long"|"long long"|"long long int"|"float"|"double"|"long double"|"auto"|"char"
L [A-Za-z]
D [0-9]

%%

{F} return LOOP;
{K} return KEY;
{L}({L}|{D})* { if(check(yytext)){ yyerror("syntax error"); } return IDEN; }
{D}+|("-"{D}+) return NUMB;
";" { charSetLen = 0, flag = 0; return SEMI; }
"," return COMM;
[ \t]* ;
\n { flag = 1; return NL; };
">="|"=="|"<="|"!="|"<"|">" return RO;
"+"|"-"|"*"|"/" return AO;
"&&"|"||" return LO;
"!" return LNOT;
"&"|"|"|"^" return BO;
"(" return PO;
")" return PC;
"=" return EQ;
{L}({L}|{D})*("++"|"--") return UU;
"+="|"-="|"*="|"/="|"%=" return BU;

%%

int yywrap()
{
    return 0;
}
