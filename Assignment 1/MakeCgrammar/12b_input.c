int main(){
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
    return 0;
    
}
