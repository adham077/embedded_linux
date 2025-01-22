#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdarg.h>

void swap(char* ,char* );
uint32_t itoa(int32_t,char*,uint32_t);

//supports only %d for integer and %s or %S for strings(character buffers)
uint32_t my_print(const char*, ... );

int main(int argc,char* argv[]){
    char arr[] = "Adham Walaa";
    uint32_t size = my_print("Name: %s\nage:%d%d\n%s\n",arr,2,3,"top");
    return 0;
}
 
uint32_t my_print(const char* str, ...  ){
    uint32_t final_string_size = 0;

    va_list args;
    va_start(args,str);
    
    for(uint32_t i=0;str[i];i++){
        if(str[i]=='%'){
            switch(str[i+1]){
                case 'd':
                    char buff[11];
                    uint32_t val = va_arg(args,int);
                    uint32_t val_size = itoa(val,buff,11);
                    final_string_size += val_size;
                    i++;
                    break;
                case 's':
                case 'S':
                    char* s = va_arg(args,char*);
                    for(uint32_t j=0;s[j];j++){
                        final_string_size++;                        
                    }
                    i++;
                    break;
                default:
                    final_string_size++;
                    break;
            }
        }
        else{
            final_string_size++;
        }
    }


    char* final_string = (char*)malloc((final_string_size+1)*sizeof(char));
    va_end(args);
    va_start(args,str);
 
    uint32_t final_string_count =0;

    for(uint32_t i=0;str[i];i++){
        if(str[i]=='%'){
            switch(str[i+1]){
                case 'd':
                    int val = va_arg(args,int);
                    char buff[11];
                    uint16_t int_count = itoa(val,buff,12);
                    for(int j=0;buff[j];j++)
                        final_string[final_string_count++] = buff[j];
                    
                    i++;
                    break;
                case 's':
                case 'S':
                    char* s = va_arg(args,char*);
                    for(int m=0;s[m];m++)
                        final_string[final_string_count++] = s[m];
                    i++;
                    break;
                default:
                    final_string[final_string_count++]=str[i];
            }   
        }
        else{
            final_string[final_string_count++] = str[i]; 
        }
    }
    final_string[final_string_count] = '\0';
    
    write(1,final_string,final_string_size);
    va_end(args);
    free(final_string);

    return final_string_count-1;
}

uint32_t itoa(int32_t num,char* str,uint32_t str_size){
    uint32_t i = 0;
    if(num==0){
        str[i++] = '0';
        str[i] = '\0';
    }
    uint8_t is_negative = 0;
    if(num<0){
        is_negative = 1;
        num *= -1;
    }
    while(num>0){
        str[i++] = num%10 + '0';
        num /= 10;
    }
    if(is_negative){
        str[i++] = '-';
    }
    str[i] = '\0';
    uint32_t start = 0;
    uint32_t end = i-1;
    while(start<end){
        swap(&str[start],&str[end]);
        start++;
        end--;
    }
    return i;
}

void swap(char* a,char* b){
    char temp = *a;
    *a = *b;
    *b = temp;
}