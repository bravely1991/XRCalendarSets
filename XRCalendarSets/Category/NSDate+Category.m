//
//  NSDate+Category.m
//  XRCalendarWeekView
//
//  Created by brave on 2018/5/26.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

- (NSDate *)nextDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.firstWeekday = 1;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:kCFCalendarUnitYear |kCFCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setDay:day];
    return [calendar dateByAddingComponents:adcomps toDate:self options:NSCalendarWrapComponents];
}

- (NSString *)day {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:self];
}


@end
