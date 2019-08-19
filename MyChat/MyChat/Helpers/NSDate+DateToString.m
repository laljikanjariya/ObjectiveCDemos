//
//  NSDate+DateToString.m
//  MyChat
//
//  Created by Siya9 on 17/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "NSDate+DateToString.h"

@implementation NSDate (DateToString)
@dynamic timeOfDate,stringDateOfDate,dateAndTimeOfDate;

-(NSString *)timeOfDate{

    NSDate * dateCurrent = [NSDate date];
    NSTimeInterval secondsBetween = [dateCurrent timeIntervalSinceDate:self];
    if (secondsBetween <= 60) {
        return @"just now";
    }
    else if (secondsBetween <= 3600) {
        return [NSString stringWithFormat:@"%d minute ago",(int)secondsBetween/60];
    }
    else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        return [formatter stringFromDate:self];
    }
}

-(NSString *)stringDateOfDate{
    
    NSDate * dateCurrent = [NSDate date];
    NSTimeInterval secondsBetween = [dateCurrent timeIntervalSinceDate:self];
    if (secondsBetween<=3600) {
        return @"To Day";
    }
    else if (secondsBetween<=7200) {
        return @"Yesterday";
    }
    else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd/MMM/yyyy"];
        return [formatter stringFromDate:self];
    }
}

-(NSString *)dateAndTimeOfDate{
    return [NSString stringWithFormat:@"%@ - %@",[self timeOfDate],[self stringDateOfDate]];
}

@end
