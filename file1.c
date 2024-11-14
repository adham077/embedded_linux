#include "stdio.h"
#include "sub.c"
#include "add.c"

int main(void){
    int a  =10;
    int b = 15;
    printf("hello world\n");
    printf("%d %d",add(a,b),sub(a,b));
}