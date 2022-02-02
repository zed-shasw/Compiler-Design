#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int solve(char *a)
{
    int count = 0, l = strlen(a);
    for (int i = 0; i < l; i++)
    {
        if (a[i] == 'a')
            count++;
    }
    return count%2;
}

int main()
{
    char a[100];
    while (scanf("%s", a) == 1)
    {
        int temp = solve(a);
        if (temp == 0)
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
