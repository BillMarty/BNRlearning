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

- (instancetype)init;
+ (DBMScannerData *)initWithContentsOfFile:(NSURL *)scannerDataFile;


@end
