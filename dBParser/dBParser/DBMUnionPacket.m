//
//  DBMUnionPacket.m
//  dBParser
//
//  Created by Bill Marty on 12/31/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMUnionPacket.h"
#import "loggingMacros.h"

@implementation DBMUnionPacket

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
        _statusPacket = nil;
    }
    return self;
}
    
+ (DBMUnionPacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr {
    DBMUnionPacket *aUP = [DBMUnionPacket new];
    const unsigned char *bytePtrCopy2 = bytePtr;    //Used only in log statement.
    
    bytePtr = [aUP readDBIHeader:bytePtr];
    
    //Assume we're a 'J' packet...
    NSAssert(aUP.packetType == 'J', @"!!DBMImagePacket type error: not 'J'!!");
    aUP.packetTypeString = @"dBJ";
    
    // 'J' packet means there's a status packet to read.
    aUP.statusPacket = [DBMStatusPacket packetWithBytesAtPtr:bytePtr];
    bytePtr = aUP.statusPacket.finalBytePtr;
    //Is there also a data packet to read?
    NSUInteger headerPlusStatus = 32 + aUP.statusPacket.length;
    if(aUP.totalBytes > headerPlusStatus) {
        NSUInteger imageDataSize = aUP.totalBytes - headerPlusStatus;
        aUP.imageData = [NSData dataWithBytes:bytePtr length:imageDataSize];
        bytePtr += imageDataSize;
        //In the future, instantiate an image object here.
    }
    
    aUP.finalBytePtr = bytePtr;
    MyLog(@"Union Packet: initialBytePtr %p, finalBytePtr %p", bytePtrCopy2, aUP.finalBytePtr);
    
    return aUP;
}


@end
