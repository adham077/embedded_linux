#include <stdio.h>
#include <fcntl.h>
#include <string.h>


int main(int argc,char* argv[]){   
    int var;
    var = open("/sys/class/leds/input3::capslock/brightness",O_RDWR);
    char* valid_inputs[2] = {"0","1"}; 
 

    if(argc==2){
        int valid = 0;
        for(int i=0;i<(sizeof(valid_inputs)/sizeof(char*));i++){
            if(!strcmp(argv[1],valid_inputs[i])){
                valid = 1;
                break;
            }
        }
        if(valid){
            dprintf(3,"%s",argv[1]);
            strcmp(argv[1],"0")? printf("Caps lock on\n"):printf("Caps lock off\n");
        }
        else{
            dprintf(2,"%s","invalid argument\n");
        }
    }
    else{
        dprintf(2,"%s","invalid no. of arguments\n");
    }
    return 0;
}