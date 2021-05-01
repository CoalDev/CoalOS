void kmain(){
    char* vid_mem = (char *) 0xb8000;
    char* str = "Loaded Kernel successfully!!";

    *vid_mem = 'X';
    int j = 0;
    for(int i = 0; i < 56; i+=2){
        *(vid_mem+i) = str[j];
        j++;
    }
}