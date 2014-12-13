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

- (instancetype)init;
+ (DBMScannerData *)initWithContentsOfFile:(NSURL *)scannerDataFile;


@end
