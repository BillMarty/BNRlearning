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

@implementation DBMScannerData

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
        _dbPackets = [NSMutableArray new];
    }
    return self;
}

+ (DBMScannerData *)initWithContentsOfFile:(NSURL *)scannerDataFile;
{
    DBMScannerData *myData = [DBMScannerData new];
    
    //Do some checking on the URL
    if (scannerDataFile.isFileURL) {
        myData.fileData = [NSData dataWithContentsOfURL:scannerDataFile];
    } else {
        MyLog(@"!!URL is not a file!! %@", scannerDataFile);
        
        return nil;
    }
    
    //What kind of dBobject do I see?
    unsigned char packetType[4] = {0,0,0,0};
    [myData.fileData getBytes:packetType length:3];
    MyLog(@"packetType %s", packetType);
    
    const unsigned char *bytes = (const unsigned char *)myData.fileData.bytes;
    
    //Grab the packet.
    switch(packetType[2]) {
        case 'I': {
            DBMImagePacket *anImagePacket = [DBMImagePacket packetWithBytesAtPtr:bytes];
            MyLog(@"anImagePacket %@", anImagePacket);
            //[myData.dbPackets addObject:anImagePacket];
            }
            break;
            
        default:
            MyLog(@"!!Unrecognized packet type!!");
            break;
    }
    
    
    return myData;
}


@end
