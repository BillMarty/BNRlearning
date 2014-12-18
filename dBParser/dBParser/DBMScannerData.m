//
//  DBMScannerData.m
//  dBParser
//
//  Created by Bill Marty on 12/12/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMScannerData.h"
#import "loggingMacros.h"
#import "DBMImagePacket.h"
#import "DBMStatusPacket.h"

@implementation DBMScannerData

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
        _dbPackets = [NSMutableArray new];
        _bytes = nil;
        _bytesEnd = nil;
    }
    return self;
}

+ (DBMScannerData *)initWithContentsOfFile:(NSURL *)scannerDataFile;
{
    DBMScannerData *myData = [DBMScannerData new];
    NSData *fileData;       //local scope - discarded when we return.
    
    //Do some checking on the URL
    if (scannerDataFile.isFileURL) {
        fileData = [NSData dataWithContentsOfURL:scannerDataFile];
    } else {
        MyLog(@"!!URL is not a file!! %@", scannerDataFile);
        
        return nil;
    }
    
    myData.bytes = (const unsigned char *)fileData.bytes;
    NSUInteger length = fileData.length;
    myData.bytesEnd = myData.bytes + length;
    
    do {        
        //Grab the packet.
        unsigned char packetType = [myData parsePacketType];
        switch(packetType) {
            case 'I':
            case 'J':
                {
                    DBMImagePacket *anImagePacket = [DBMImagePacket packetWithBytesAtPtr:myData.bytes];
                    MyLog(@"anImagePacket %@", anImagePacket);
                    myData.bytes = anImagePacket.finalBytePtr;
                    [myData.dbPackets addObject:anImagePacket];
                }
                break;
                
            case '%':
                {
                    DBMStatusPacket *aStatusPacket = [DBMStatusPacket packetWithBytesAtPtr:myData.bytes];
                    MyLog(@"aStatusPacket %@", aStatusPacket);
                    myData.bytes = aStatusPacket.finalBytePtr;
                    [myData.dbPackets addObject:aStatusPacket];
                }
                break;
                
            case 0:
                //Can get here if there's whitespace at the end of the file ('\r\n').
                break;
                
            default:
                MyLog(@"!!Unrecognized packet type %c!!", packetType);
                break;
        }
        MyLog(@"bytes %p, endBytes %p", myData.bytes, myData.bytesEnd);
        
    } while(myData.bytes < myData.bytesEnd);
    
    MyLog(@"Read a total of %lu packets.", (unsigned long)myData.dbPackets.count);
    
    return myData;
}

- (const unsigned char)parsePacketType {
    //Scan forward, looking for dBx packets, where x indicates the packetType.
    //Discard whitespace.
    //Leave self.bytes pointing at the beginning of the dBx string.
    const unsigned char *localBytePtr = self.bytes;
    unsigned char discard[4] = {0,0,0,0};
    unsigned char packetType[4] = {0,0,0,0};
    unsigned char aChar;
    NSUInteger j = 0;
    NSUInteger k = 0;
    BOOL isFinished = NO;
    
    do {
        aChar = *localBytePtr++;
        switch(aChar) {
            case '\r':
            case '\n':
            case ' ':
                //whitespace - discard it and advance the ivar bytes ptr.
                discard[j++] = aChar;
                self.bytes++;
                break;
                
            case 'd':
            case 'B':
                //packet identifier characters, hold them, don't advance the ivar bytes ptr.
                packetType[k++] = aChar;
                break;
                
            case 'I':
            case 'J':
            case '%':
            case '<':
                //packet identifier characters, hold them, don't advance the ivar bytes ptr.
                packetType[k++] = aChar;
                if( packetType[0] == 'd' && packetType[1] == 'B' ) {
                    isFinished = YES;
                }
                break;
                
            default:
                MyLog(@"!!UNEXPECTED CHARACTER IN FILE!!");
                break;
        }
        
    } while(!isFinished && (self.bytes < self.bytesEnd) );
    
    if(!isFinished) {
        MyLog(@"reached end of data file");
    } else {
        MyLog(@"packetType %s", packetType);
    }
    
    return packetType[2];
}


@end
