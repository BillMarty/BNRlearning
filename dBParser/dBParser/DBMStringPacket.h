//
//  DBMStringPacket.h
//  dBParser
//
//  Created by Bill Marty on 1/2/15.
//  Copyright (c) 2015 DBMEDx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMStringPacket : NSObject

@property NSUInteger packetHead1;
@property NSUInteger packetHead2;
@property NSUInteger packetType;
@property NSUInteger packetClose;

@property NSString *string;
@property const unsigned char *finalBytePtr;
@property NSString *packetTypeString;

- (instancetype)init;
+ (DBMStringPacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr;
- (NSString *)description;

@end
