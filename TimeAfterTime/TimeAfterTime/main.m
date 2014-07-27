//
//  main.m
//  TimeAfterTime
//
//  Created by Bill Marty on 7/11/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSDate *now = [[NSDate alloc] init];
        NSLog(@"This NSDat object lives at %p", now);
        NSLog(@"The date is %@", now);
        
        double seconds = [now timeIntervalSince1970];
        NSLog(@"It has been %f seconds since the start of 1970.", seconds);
        
        NSDate *then = [now dateByAddingTimeInterval:24*3600];
        NSLog(@"The future date is %@", then);
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSLog(@"My calendar is %@", [cal calendarIdentifier]);
        unsigned long day = [cal ordinalityOfUnit:NSDayCalendarUnit
                                           inUnit:NSMonthCalendarUnit
                                          forDate:now];
        NSLog(@"This is day %lu of the month", day);
        
        //Chapter 14 challenge...
        
        // First, build my DOB
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setYear:1963];
        [comps setMonth:8];
        [comps setDay:31];
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
        
        //NSCalendar *cal = [NSCalendar currentCalendar];
        //I also have a cal object above :-)
        NSDate *dob = [cal dateFromComponents:comps];
        
        //We've already got a "now" date object from above.
        double secondsSinceBirth = [now timeIntervalSinceDate:dob];
        double daysSinceBirth = secondsSinceBirth/24.0/3600.0;
        NSLog(@"Day's in my life (so far) %f", daysSinceBirth);
        
    }
    return 0;
}

