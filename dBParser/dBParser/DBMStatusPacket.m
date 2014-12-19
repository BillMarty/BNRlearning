//
//  DBMStatusPacket.m
//  dBParser
//
//  Created by Bill Marty on 12/17/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMStatusPacket.h"
#import "loggingMacros.h"

@implementation DBMStatusPacket

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
    }
    return self;
}

+ (DBMStatusPacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr {
    DBMStatusPacket *aSP = [DBMStatusPacket new];
    const unsigned char *bytePtrCopy = bytePtr;
    const unsigned char *bytePtrCopy2 = bytePtr;

    //Read in the dBI header values
    aSP.dChar = *bytePtr++;
    aSP.BChar = *bytePtr++;
    aSP.pctChar = *bytePtr++;
    MyLog(@"packetType %c%c%c", (unsigned char)aSP.dChar, (unsigned char)aSP.BChar, (unsigned char)aSP.pctChar);
    if(aSP.pctChar == '%') { aSP.packetTypeString = @"dB%"; }
    
    aSP.checksum = *bytePtr++;
    
    const unsigned int *uintPtr = (const unsigned int*)bytePtr;
    aSP.length = *uintPtr++;
    aSP.timeInTics = *uintPtr++;
    aSP.current = *uintPtr++;
    aSP.voltage = *uintPtr++;
    aSP.tempC = *uintPtr++;
    aSP.softwareVersion = *uintPtr++;
    aSP.softwareSHA = *uintPtr++;
    aSP.bbimageVersion = *uintPtr++;
    aSP.noiseFloor = *uintPtr++;
    aSP.myBDA = *uintPtr++;
    aSP.consoleBDA = *uintPtr++;
    aSP.flags = *uintPtr++;
    aSP.errCode = *uintPtr++;
    aSP.revOdometer = *uintPtr++;
    aSP.bootCount = *uintPtr++;
    aSP.stallCount = *uintPtr++;
    aSP.scanCount = *uintPtr++;
    MyLog(@"scannerBDA (0006)%lx, consoleBDA (0006)%lx, softwareVersion %lx",
          aSP.myBDA, aSP.consoleBDA, aSP.softwareVersion);
    
    //Read in the array of future EEPROM values.
    NSUInteger i = 0;
    const unsigned int *uintEndPtr = (const unsigned int *)(bytePtrCopy + aSP.length);
    while( (uintPtr < uintEndPtr) && (i < MAX_ARRAY_SIZE) ) {
        rsvdUintArray[i++] = *uintPtr++;
    }
    MyLog(@"uintPtr %p, uintEndPtr %p, i %ld", uintPtr, uintEndPtr, i);
    
    //Verify the checksum
    unsigned char checksum = 0;
    for(i=0; i< aSP.length; i++) {
        checksum += *bytePtrCopy++;
    }
    if(checksum) {
        MyLog(@"!!checksum error!!");
    } else {
        MyLog(@"checksum verified :-)");
    }
    
    aSP.finalBytePtr = (const unsigned char *)uintPtr;
    
    MyLog(@"Status Packet: initialBytePtr %p, finalBytePtr %p", bytePtrCopy2, aSP.finalBytePtr);
    
    return aSP;
}

- (NSString *)description {
    NSString *statusPacketDescription = [NSString stringWithFormat:@"scanner (0006)%lx, scanCount %ld", self.myBDA, self.scanCount];
    
    return statusPacketDescription;
}


@end
