#include<stdio.h>

/* Author: Yinsheng Dong
 Date: 2018/02/05
 Description:
 This is the input_5_test similar programs
 */

int main()
{
    printf("Hello Example\n"); //prints "Hello World"
    
    int a; char b; int a,b,c;
    
    const double pi = 3.14;
    
    unsigned int a;
    signed int b;
    
    int a,b;
    a = 100;
    b = a -10;
    a = a - 3;
    
    int a;
    scanf("%d",&a);
    a = a * 2;
    printf("Number you entered %d",a);
    
    int mark; char pass;
    scanf("%d",&mark);
    if (mark > 10)
        pass = 'y';
    scanf("%d",&mark);
    if (mark > 20) pass = 'y';
    else pass = 'n';
    
    int mark;
    char pass;
    scanf("%d",&mark);
    if (mark > 40){
        pass = 'y';
        printf("Good");
    }else{
        pass = 'n';
        printf("Not good");
    }
    
    int q,s;
    scanf("%d",&q);
    scanf("%d",&s);
    if(q > 0 && s > 0){
        printf("good");
    }
    if(q == 0 && s == 0){
        printf("not good");
    }
    if(!(q > 0) && !(s > 0)){
        printf("bad");
    }
    
    char computer;
    printf("ss");
    printf("bb");
    scanf("%c",&computer);
    switch (computer) {
        case 'a':
            printf("a computer");
            break;
        case'b':
            printf("b computer");
            break;
        default:
            printf("not good");
    }
    
    int i;
    for (i=0; i<=100; i++)
        printf("hey\n");
    
    int i,b;
    scanf("%d", &b);
    i=0;
    while(i<=100){
        i++;
        printf("d\n", b);
    }
    
    int i, a;
    scanf("%d", &a);
    i = 0;
    
    do{
        i++; printf("%d\n",a);
        
    }while(i <= a);
    
    int i;
    while(i<10)
    {
        i++;
        if(i<0)
            break;
    }
    
    int i;
    while (i < 100)
    {
        i++; continue;
        printf("Hello\n");
    }return 0;
}

