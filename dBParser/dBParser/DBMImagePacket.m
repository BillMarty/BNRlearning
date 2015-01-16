//
//  DBMImagePacket.m
//  dBParser
//
//  Created by Bill Marty on 12/12/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMImagePacket.h"
#import "loggingMacros.h"
#import "DBMStatusPacket.h"
#import "DBMDisplayElement.h"

@implementation DBMImagePacket

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
        _imageData = nil;
        _displayElementArray = [NSMutableArray new];
    }
    return self;
}

+ (DBMImagePacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr {
    DBMImagePacket *anIP = [DBMImagePacket new];
    const unsigned char *bytePtrCopy2 = bytePtr;    //Used only in log statement.
    
    bytePtr = [anIP readDBIHeader:bytePtr];
    
    //Assume we're an 'I' packet...
    NSAssert(anIP.packetType == 'I', @"DBMImagePacket type error: not 'I'");
    anIP.packetTypeString = @"dBI";
    
    //Is there data to read?
    if(anIP.totalBytes > 32) {
        NSUInteger imageDataSize = anIP.totalBytes - 32;
        anIP.imageData = [NSData dataWithBytes:bytePtr length:imageDataSize];
        bytePtr += imageDataSize;
        //In the future, instantiate an image object here.
    }
    
    anIP.finalBytePtr = bytePtr;
    MyLog(@"Image Packet: initialBytePtr %p, finalBytePtr %p", bytePtrCopy2, anIP.finalBytePtr);
    
    return anIP;
}

- (const unsigned char *)readDBIHeader:(const unsigned char *)bytePtr {
    const unsigned char *bytePtrCopy = bytePtr;     //Used in checksum calculation.
    
    LogMethod();
    
    //Read in the dBI header values
    self.packetHead1 = *bytePtr++;
    self.packetHead2 = *bytePtr++;
    self.packetType = *bytePtr++;
    MyLog(@"packetType %c%c%c", (unsigned char)self.packetHead1, (unsigned char)self.packetHead2, (unsigned char)self.packetType);
    
    self.checksum = *bytePtr++;
        DBMDisplayElement *de = [DBMDisplayElement new];
        de.keyString = @"checksum";
        de.value = self.checksum;
        de.valueString = [NSString stringWithFormat:@"0x%lx", self.checksum];
        de.unitsString = nil;
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);
    
    const unsigned short *shortPtr = (const unsigned short*)bytePtr;
    self.dim1 = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"dim1";
        de.value = self.dim1;
        de.valueString = [NSString stringWithFormat:@"%ld", self.dim1];
        de.unitsString = @"bytes";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);
    
    self.dim2 = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"dim2";
        de.value = self.dim2;
        de.valueString = [NSString stringWithFormat:@"%ld", self.dim2];
        de.unitsString = @"scanlines";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.dim3 = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"dim3";
        de.value = self.dim3;
        de.valueString = [NSString stringWithFormat:@"%ld", self.dim3];
        de.unitsString = @"planes";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.dim4 = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"dim4";
        de.value = self.dim4;
        de.valueString = [NSString stringWithFormat:@"%ld", self.dim4];
        de.unitsString = @"frames";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    MyLog(@"dims %lu, %lu, %lu, %lu", self.dim1, self.dim2, self.dim3, self.dim4);
    self.axialOffset = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"axialOffset";
        de.value = self.axialOffset;
        de.valueString = [NSString stringWithFormat:@"%ld", self.axialOffset];
        de.unitsString = @"micrometers";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.axialResolution = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"axialResolution";
        de.value = self.axialResolution;
        de.valueString = [NSString stringWithFormat:@"%ld", self.axialResolution];
        de.unitsString = @"100 nanometers";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.phiResolution = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"phiResolution";
        de.value = self.phiResolution;
        de.valueString = [NSString stringWithFormat:@"%ld", self.phiResolution];
        de.unitsString = @"microradians";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.sliceResolution = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"sliceResolution";
        de.value = self.sliceResolution;
        de.valueString = [NSString stringWithFormat:@"%ld", self.sliceResolution];
        de.unitsString = @"micrometers";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.timeResolution = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"timeResolution";
        de.value = self.timeResolution;
        de.valueString = [NSString stringWithFormat:@"%ld", self.timeResolution];
        de.unitsString = @"milliseconds";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);
    
    bytePtr = (const unsigned char *)shortPtr;
    self.codingScheme = *bytePtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"codingScheme";
        de.value = self.codingScheme;
        switch(self.codingScheme) {
            case 2:
                de.valueString = @"RAW12BIT";
                break;
            case 3:
                de.valueString = @"RAW16IT";
                break;
            case 5:
                de.valueString = @"ENVELOPED16BIT";
                break;
            case 1:
            case 4:
            case 6:
                de.valueString = @"UNIMPLEMENTED";
                break;
            default:
                de.valueString = @"UNRECOGNIZED";
                break;
        }
        de.unitsString = nil;
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.includedWalls = *bytePtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"includedWalls";
        de.value = self.includedWalls;
        de.valueString = [NSString stringWithFormat:@"%ld", self.includedWalls];
        de.unitsString = @"# of regions";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);
    
    shortPtr = (const unsigned short *)bytePtr;
    self.volume = *shortPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"volume";
        de.value = self.volume;
        if(self.volume > 4095) {
            de.valueString = @"blanking";
            de.unitsString = nil;
        } else {
            de.valueString = [NSString stringWithFormat:@"%ld", self.volume];
            de.unitsString = @"ml";
        }
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);
    
    bytePtr = (const unsigned char *)shortPtr;
    self.gainSetting = *bytePtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"gainSetting";
        de.value = self.gainSetting;
        de.valueString = [NSString stringWithFormat:@"0x%lx", self.gainSetting];
        de.unitsString = @"2 bits each: delay/slope/gain";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

    self.Qfactor = *bytePtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"Qfactor";
        de.value = self.Qfactor;
        de.valueString = [NSString stringWithFormat:@"%ld", self.Qfactor];
        de.unitsString = @"%";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);
    
    const unsigned int *intPtr = (const unsigned int *)bytePtr;
    self.totalBytes = *intPtr++;
        de = [DBMDisplayElement new];
        de.keyString = @"totalBytes";
        de.value = self.totalBytes;
        de.valueString = [NSString stringWithFormat:@"%ld", self.totalBytes];
        de.unitsString = @"bytes";
        [self.displayElementArray addObject:de];
        MyLog(@"%@", de.description);

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
    
    if( (self.totalBytes == 32) && (self.volume == BLANKING_VOLUME) ) {
        MyLog(@"This is a volume blanking message.");
    }
    
    return bytePtr;
}

- (NSString *)description {
    NSString *imagePacketDescription;
    if( (self.totalBytes == 32) && (self.volume == BLANKING_VOLUME) ) {
        imagePacketDescription = @"Volume blanking message.";
    } else {
        imagePacketDescription = [NSString stringWithFormat:@"dims: %ld %ld %ld %ld, vol %ld, size %ld", self.dim1, self.dim2, self.dim3, self.dim4, self.volume, self.totalBytes];
    }
    
    return imagePacketDescription;
}

@end
