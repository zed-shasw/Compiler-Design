%{
    #include <stdio.h> 
    #include <string.h>

    char names[10000][20], places[11000][20];
    int nameLen = 0, placeLen = 0;
    void pre()
    {
        FILE *f1 = fopen("names.txt", "r");
        char a[20];
        while(fscanf(f1, "%s", a) == 1)
        {
            strcpy(names[nameLen], a);
            nameLen++;
        }
        fclose(f1);
        FILE *f2 = fopen("places.txt", "r");
        while(fscanf(f2, "%s", a) == 1)
        {
            strcpy(places[placeLen], a);
            placeLen++;
        }
        fclose(f2);
        return;
    }

    int strcmpi(char *src, char *dst)
    {
        int n1 = strlen(src), n2 = strlen(dst);
        for(int i=0; i<n1; i++)
        {
            if(src[i]>=65 && src[i]<=90) src[i] = src[i] + 32;
        }
        for(int i=0; i<n2; i++)
        {
            if(dst[i]>=65 && dst[i]<=90) dst[i] = dst[i] + 32;
        }
        int ret = strcmp(src, dst);
        return ret;
    }

    void process(char *str)
    {
        int len = strlen(str);
        for(int i=0; i<nameLen; i++)
        {
            if(strcmpi(names[i], str) == 0)
            {
                printf("Name: %s\n", str);
                return;
            }
        }
        for(int i=0; i<placeLen; i++)
        {
            if(strcmpi(places[i], str) == 0)
            {
                printf("Place: %s\n", str);
                return;
            }
        }
        return;
    }
%}

D [0-9]
S [ ,\t\n]
L [A-Za-z]
E [^ ,\t\n]

%%

{D}{2,2}"/"{D}{2,2}"/"{D}{4,4} printf("Date: %s\n", yytext);
{L}+ process(yytext);
{S}* ;
{E}* ;

%%

int main(int argc, char *argv[])
{
    if(argc != 2)
    {
        printf("Syntax : %s <FILE_NAME>\n", argv[0]);
        exit(1);
    }
    pre();
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