%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>

    char answer[100][2];
    int stack[100];
    int top = -1;
    int ansLen = 0;

    void append(int val)
    {
        answer[ansLen][0] = val;
        answer[ansLen][1] = '\0';
        ansLen++;
        return;
    }

    int pop()
    {
        top--;
        return stack[top+1];
    }

    int isEmpty()
    {
        if(top == -1) return 1;
        return 0;
    }

    int getTop()
    {
        return stack[top];
    }

    void push(int val)
    {
        if(isEmpty())
        {
            top++;
            stack[top] = val;
            return;
        }
        char now = val;
        if(now == '(')
        {
            top++;
            stack[top] = val;
            return;
        }
        if(now == ')')
        {
            while(!isEmpty())
            {
                char tp = getTop();
                pop();
                if(tp != '(')
                {
                    append(tp);
                    continue;
                }
                break;
            }
            return;
        }
        while(!isEmpty())
        {
            char tp = getTop();
            if(now == '+' && tp != '(')
            {
                append(tp);
                pop();
                continue;
            }
            else if(now == '-' && tp != '(')
            {
                append(tp);
                pop();
                continue;
            }
            else if(now == '*' && tp != '(' && tp != '+' && tp != '-')
            {
                append(tp);
                pop();
                continue;
            }
            else if(now == '/' && tp != '(' && tp != '+' && tp != '-')
            {
                append(tp);
                pop();
                continue;
            }
            break;
        }
        top++;
        stack[top] = now;
        return;
    }

    void print()
    {
        printf("Valid Expression!\nPostfix: ");
        for(int i=0; i<ansLen; i++)
        {
            printf("%s ", answer[i]);
        }
        printf("\n\n");
        printf("Enter the infix expression: ");
        return;
    }
%}

%token KEY OP PO PC NL
%left OP

%%

stmt: 
    stmt expr NL { while(!isEmpty()){ char tp = getTop(); pop(); append(tp); } print(); ansLen = 0; }
    |
    ;

expr:
    expr OP { push(yylval); } expr;
    | PO  { push('('); } expr PC { push(')'); };
    | KEY { append(yylval); }
    ;

%%

int yyerror(char *msg)
{
    printf("%s\n", msg);
    exit(1);
}

int main()
{
    printf("Enter the infix expression: ");
    yyparse();
    return 0;
}
