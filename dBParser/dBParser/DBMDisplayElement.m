//
//  DBMDisplayElement.m
//  dBParser
//
//  Created by Bill Marty on 1/15/15.
//  Copyright (c) 2015 DBMEDx. All rights reserved.
//

#import "DBMDisplayElement.h"

@implementation DBMDisplayElement

- (instancetype)init
{
    self = [super init];
    if (self) {
        _value = 0;
    }
    return self;
}

+ (DBMDisplayElement *)elementWithKeyString:(NSString *)keyString value:(NSUInteger)value valueString:(NSString *)valueString unitsString:(NSString *)unitsString {
    
    DBMDisplayElement *de = [DBMDisplayElement new];
    de.keyString = keyString;
    de.value = value;
    de.valueString = valueString;
    de.unitsString = unitsString;
    
    return de;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"key %@ = %@, units %@", self.keyString, self.valueString, self.unitsString];
}
@end
