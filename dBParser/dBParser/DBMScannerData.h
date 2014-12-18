//
//  DBMScannerData.h
//  dBParser
//
//  Created by Bill Marty on 12/12/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMScannerData : NSObject

@property NSData *fileData;
@property NSMutableArray *dbPackets;
@property const unsigned char *bytes;
@property const unsigned char *bytesEnd;

- (instancetype)init;
+ (DBMScannerData *)initWithContentsOfFile:(NSURL *)scannerDataFile;
- (const unsigned char)parsePacketType;


@end
