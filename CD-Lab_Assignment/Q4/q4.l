%{
    #include <stdio.h>
    #include <string.h>

    int weight = 0, tresh = 50, wtSize = 0, wts[100];
    char words[100][20];

    void pre()
    {
        FILE *f = fopen("wordWeights.txt", "r");
        char a[20];
        int i=0;
        while(fscanf(f, "%s", a) == 1)
        {
            if(i%2 == 0)
            {
                strcpy(words[wtSize], a);
            }
            else
            {
                wts[wtSize] = atoi(a);
                wtSize++;
            }
            i++;
        }
        fclose(f);
        return;
    }

    void process(char *str, int mode)
    {
        if(mode == 1)
        {
            weight += 20;
            return;
        }
        int len = strlen(str);
        for(int i=0; i<len; i++)
        {
            if(str[i]>=65 && str[i]<=90) str[i] = str[i] + 32;
        }
        for(int i=0; i<wtSize; i++)
        {
            if(strcmp(words[i], str) == 0) 
            {
                weight += wts[i]; 
                break;
            }
        }
        return;
    }
%}

L [A-Za-z]
W [., \t\n]
E [^., \t\n]
D [0-9]

%%

{D}{1,3}("/"|"-"){D}{1,2} process(yytext, 1);
{L}+ process(yytext, 0);
{W}* ;
{E}* ;

%%

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        printf("Syntax: %s <File Name>\n", argv[0]);
        exit(1);
    }
    FILE *fp = fopen(argv[1], "r");
    if(fp == NULL)
    {
        printf("ERR: File does not exist.\n");
        exit(2);
    }
    pre();
    yyin = fp;
    yylex();
    if(weight >= tresh) printf("Sports Paragraph.\n");
    else printf("Not a sports paragraph.\n");
    fclose(fp);
    return 0;
}

int yywrap()
{
    return 1;
}