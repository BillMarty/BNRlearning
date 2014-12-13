//
//  DBMImagePacket.m
//  dBParser
//
//  Created by Bill Marty on 12/12/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMImagePacket.h"
#import "loggingMacros.h"

@implementation DBMImagePacket

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
    }
    return self;
}

+ (DBMImagePacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr {
    DBMImagePacket *anIP = [DBMImagePacket new];
    const unsigned char *bytePtrCopy = bytePtr;
    const unsigned char *bytePtrCopy2 = bytePtr;
    
    //Read in the dBI header values
    anIP.packetHead1 = *bytePtr++;
    anIP.packetHead2 = *bytePtr++;
    anIP.packetType = *bytePtr++;
    MyLog(@"packetType %c%c%c", (unsigned char)anIP.packetHead1, (unsigned char)anIP.packetHead2, (unsigned char)anIP.packetType);
    
    anIP.checksum = *bytePtr++;
    
    const unsigned short *shortPtr = (const unsigned short*)bytePtr;
    anIP.dim1 = *shortPtr++;
    anIP.dim2 = *shortPtr++;
    anIP.dim3 = *shortPtr++;
    anIP.dim4 = *shortPtr++;
    MyLog(@"dims %lu, %lu, %lu, %lu", anIP.dim1, anIP.dim2, anIP.dim3, anIP.dim4);
    anIP.axialOffset = *shortPtr++;
    anIP.axialResolution = *shortPtr++;
    anIP.phiResolution = *shortPtr++;
    anIP.sliceResolution = *shortPtr++;
    anIP.timeResolution = *shortPtr++;
    
    bytePtr = (const unsigned char *)shortPtr;
    anIP.codingScheme = *bytePtr++;
    anIP.includedWalls = *bytePtr++;
    
    shortPtr = (const unsigned short *)bytePtr;
    anIP.volume = *shortPtr++;
    
    bytePtr = (const unsigned char *)shortPtr;
    anIP.gainSetting = *bytePtr++;
    anIP.Qfactor = *bytePtr++;
    
    const unsigned int *intPtr = (const unsigned int *)bytePtr;
    anIP.totalBytes = *intPtr++;
    MyLog(@"totalBytes = %lu", anIP.totalBytes);
    
    bytePtr = (const unsigned char *)intPtr;
    
    //Verify the checksum
    unsigned char checksum = 0;
    unsigned char i;
    for(i=0; i<32; i++) {
        checksum += *bytePtrCopy++;
    }
    if(checksum) {
        MyLog(@"!!checksum error!!");
    } else {
        MyLog(@"checksum verified :-)");
    }
    
    if( (anIP.totalBytes == 32) && (anIP.volume == BLANKING_VOLUME) ) {
        MyLog(@"This is a volume blanking message.");
    }
    
    //Is there data to read?
    if(anIP.totalBytes > 32) {
        NSUInteger imageDataSize = anIP.totalBytes - 32;
        anIP.imageData = [NSData dataWithBytes:bytePtr length:imageDataSize];
        
        anIP.finalBytePtr = bytePtr + imageDataSize;
        
        //In the future, instantiate an image object here.
        
    } else {
        anIP.finalBytePtr = bytePtr;
    }
    
    MyLog(@"initialBytePtr %p, finalBytePtr %p", bytePtrCopy2, anIP.finalBytePtr);
    
    return anIP;
}

@end
