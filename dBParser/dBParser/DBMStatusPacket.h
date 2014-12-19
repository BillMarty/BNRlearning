//
//  DBMStatusPacket.h
//  dBParser
//
//  Created by Bill Marty on 12/17/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBMStatusPacket : NSObject

/*
 * Fields of the dB% status message:
 */
//typedef struct {
//    //packet header
//    unsigned char	dChar;
//    unsigned char	BChar;
//    unsigned char	pctChar;
//    unsigned char	checksum;
//    unsigned int	length;
//    //Info from '%' command
//    unsigned int	timeInTics;
//    unsigned int	current;
//    unsigned int	voltage;
//    unsigned int	tempC;
//    //Info from 'v' command
//    unsigned int	softwareVersion;
//    unsigned int	softwareSHA;
//    unsigned int	bbimageVersion;
//    unsigned int	noiseFloor;
//    //Info from battery backed RAM
//    unsigned int	myBDA;
//    unsigned int	consoleBDA;
//    unsigned int	flags;
//    unsigned int	errCode;
//    unsigned int	revOdometer;
//    unsigned int	bootCount;
//    unsigned int	stallCount;
//    unsigned int	scanCount;
//    //Info from EEPROM
//    unsigned int rsvdUintArray[46];
//}dBPercentMssg;

@property NSUInteger dChar;
@property NSUInteger BChar;
@property NSUInteger pctChar;
@property NSUInteger checksum;
@property NSUInteger length;
@property NSUInteger timeInTics;
@property NSUInteger current;
@property NSUInteger voltage;
@property NSUInteger tempC;
@property NSUInteger softwareVersion;
@property NSUInteger softwareSHA;
@property NSUInteger bbimageVersion;
@property NSUInteger noiseFloor;
@property NSUInteger myBDA;
@property NSUInteger consoleBDA;
@property NSUInteger flags;
@property NSUInteger errCode;
@property NSUInteger revOdometer;
@property NSUInteger bootCount;
@property NSUInteger stallCount;
@property NSUInteger scanCount;

@property const unsigned char *finalBytePtr;
@property NSString *packetTypeString;



- (instancetype)init;
+ (DBMStatusPacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr;
- (NSString *)description;

@end

#define MAX_ARRAY_SIZE  64
NSUInteger rsvdUintArray[MAX_ARRAY_SIZE];       //Oversized, so that we don't overrun it.

