//
//  DBMStringPacket.m
//  dBParser
//
//  Created by Bill Marty on 1/2/15.
//  Copyright (c) 2015 DBMEDx. All rights reserved.
//

#import "DBMStringPacket.h"
#import "loggingMacros.h"

@implementation DBMStringPacket

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
        _string = nil;
    }
    return self;
}

+ (DBMStringPacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr {
    DBMStringPacket *aSP = [DBMStringPacket new];
    const unsigned char *bytePtrCopy = bytePtr;    //Used only in log statement.
    
    aSP.packetHead1 = *bytePtr++;
    aSP.packetHead2 = *bytePtr++;
    aSP.packetType = *bytePtr++;
    
    NSAssert(aSP.packetType == '<', @"!!String packetType error: %lu!!", aSP.packetType);
    
    const unsigned char *strStart = bytePtr;
    NSUInteger length;
    BOOL endFound = NO;
    for(length = 0; length < 60; length++) {
        if(*bytePtr++ == '>') {
            aSP.packetClose = *(bytePtr -1);
            endFound = YES;
            break;
        }
    }
    
    if(endFound) {
        aSP.string = [[NSString new] initWithBytes:strStart length:length encoding:NSASCIIStringEncoding];
    }
    
    aSP.finalBytePtr = bytePtr;
    MyLog(@"String: %@", aSP.string);
    MyLog(@"String Packet: initialBytePtr %p, finalBytePtr %p", bytePtrCopy, aSP.finalBytePtr);
    
    return aSP;
}

- (NSString *)description {
    return self.string;
}



@end
