//
//  DBMScannerData.m
//  dBParser
//
//  Created by Bill Marty on 12/12/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMScannerData.h"
#import "loggingMacros.h"

@implementation DBMScannerData

- (instancetype)init
{
    self = [super init];
    if (self) {
        LogMethod();
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
    
    
    return myData;
}


@end
