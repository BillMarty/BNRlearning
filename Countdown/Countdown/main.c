//
//  main.c
//  Countdown
//
//  Created by Bill Marty on 7/11/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#include <readline/readline.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, const char * argv[])
{
    printf("Count down start value? ");
    const char *numText = readline(NULL);
    int startVal = atoi(numText);
    startVal -= startVal%3;
    
    for(int i=startVal; i>=0; i-=3) {
        printf("%d\n",i);
        if(i%5 == 0) {
            printf("Found one!\n");
        }
    }
    
    int i = 333;
    int *ptr = &i;
    printf("Size of pointer is %zu\n", sizeof(ptr));
    
    short j = 334;
    printf("Size of short is %zu\n", sizeof(j));
    
    return 0;
}

