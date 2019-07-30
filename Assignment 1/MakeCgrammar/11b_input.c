int main()
{
    int number;
    char s;
    scanf("%d",&number);
    if (number > 1){
        s = 'y';
        printf("Good");
    }else
    {
        s = 'b';
        printf("Bad");
    }
    return 0;
}
