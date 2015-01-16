//
//  DBMDisplayElement.h
//  dBParser
//
//  Created by Bill Marty on 1/15/15.
//  Copyright (c) 2015 DBMEDx. All rights reserved.
//
//  This class was created to hold the display information for one element of (for instance)
//      a dBI header.  I expect an array of these to be used to populate a table displaying
//      header info.

#import <Foundation/Foundation.h>

@interface DBMDisplayElement : NSObject

@property NSString *keyString;
@property NSUInteger value;
@property NSString *valueString;
@property NSString *unitsString;

- (instancetype)init;
+ (DBMDisplayElement *)elementWithKeyString:(NSString *)keyString value:(NSUInteger)value valueString:(NSString *)valueString unitsString:(NSString *)unitsString;
- (NSString *)description;


@end
