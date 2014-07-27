//
//  main.m
//  computerName
//
//  Created by Bill Marty on 7/11/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSHost *myComputer = [NSHost currentHost];
        NSString *myCompName = [myComputer localizedName];
        NSLog(@"My computer's name is \"%@\"\n", myCompName);
        
    }
    return 0;
}

