//
//  DBMUnionPacket.h
//  dBParser
//
//  Created by Bill Marty on 12/31/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import "DBMImagePacket.h"

@interface DBMUnionPacket : DBMImagePacket

@property DBMStatusPacket *statusPacket;

+ (DBMUnionPacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr;

@end
