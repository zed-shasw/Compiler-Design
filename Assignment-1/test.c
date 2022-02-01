#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <limits.h>
#include <string.h>

int fun(char *a)
{
    int l = strlen(a);
    int count = 0;
    for (int i = 0; i < l; i++)
    {
        if (a[i] == 'a')
            count++;
    }
    count %= 2;
    return count;
}

int main()
{
    char a[100];
    while (scanf("%s", a) == 1)
    {
        int ret = fun(a);
        if (ret == 0)
        {
            printf("Following\n\n");
        }
        else
        {
            printf("Not Following\n\n");
        }
    }
    return 0;
}
