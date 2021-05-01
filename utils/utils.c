void memcpy(char* source, char* dest, int size){
    int i;
    for(i = 0; i < size; i++){
        *(dest + i) = *(source + i);
    }
}

void itoa(int num, char str[]){
    int i;
    int sign;
    if((sign = num) < 0){
        num = -num;
    }

    i = 0;
    do{
        str[i++] = num % 10 + '0';
    } while((num /= 10) > 0);

    if(sign < 0){
        str[i++] = '-';
    }
    str[i] = '\0';
}