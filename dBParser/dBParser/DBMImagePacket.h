//
//  DBMImagePacket.h
//  dBParser
//
//  Created by Bill Marty on 12/12/14.
//  Copyright (c) 2014 DBMEDx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBMStatusPacket.h"

@interface DBMImagePacket : NSObject

#define BLANKING_VOLUME     0xf000

//Here's the scanner code definition of the dBImessageHeader:
//32byte Structure used to communicate data between scanner and external device.
//Defined in "dBlink communication protocol", RD-030-0019-13
//typedef struct {
//    unsigned char	packetHead1;		// MSByte = 'd' (0x64)
//    unsigned char	packetHead2;		// LSByte = 'B' (0x42)
//    unsigned char	packetType;			// MSByte = 'I' (0x49)
//    unsigned char	checksum;			// chksum value such that if you modular sum the entire header you get 0x00
//    unsigned short	dim1;				// Amode #bytes (depends on coding used)
//    unsigned short	dim2;				// Bmode #scanlines
//    unsigned short	dim3;				// Cmode #slices
//    unsigned short	dim4;				// Dmode #frames
//    unsigned short	axialOffset;		// Distance from apex to 1st pt (micrometers)
//    unsigned short	axialResolution;	// Distance between points (100 nanometers)
//    unsigned short	phiResolution;		// Angular scanline separation (microradians)
//    unsigned short	sliceResolution;	// Distance between slices (micrometers)
//    unsigned short	timeResolution;		// Time between frames (milliseconds)
//    unsigned char	codingScheme;		// MSByte = coding scheme
//    unsigned char	includedWalls;		// LSByte = included walls
//    unsigned short	volume;				// Located (Bladder) Volume (ml)
//    unsigned char	gainSetting;		// 8LSB=sequence frames, 3LSB=fixed, 2LSB=slope, 1LSB=delay
//    unsigned char	Qfactor;			// Q factor percentage (125% = 125)
//    unsigned int	totalBytes;			// total bytes in message = size(image data) + 32
//} dBImessageHeader;
@property NSUInteger packetHead1;
@property NSUInteger packetHead2;
@property NSUInteger packetType;
@property NSUInteger checksum;
@property NSUInteger dim1;
@property NSUInteger dim2;
@property NSUInteger dim3;
@property NSUInteger dim4;
@property NSUInteger axialOffset;
@property NSUInteger axialResolution;
@property NSUInteger phiResolution;
@property NSUInteger sliceResolution;
@property NSUInteger timeResolution;
@property NSUInteger codingScheme;
@property NSUInteger includedWalls;
@property NSUInteger volume;
@property NSUInteger gainSetting;
@property NSUInteger Qfactor;
@property NSUInteger totalBytes;

@property DBMStatusPacket *statusPacket;
@property NSData *imageData;
@property const unsigned char *finalBytePtr;


- (instancetype)init;
+ (DBMImagePacket *)packetWithBytesAtPtr:(const unsigned char *)bytePtr;


@end
