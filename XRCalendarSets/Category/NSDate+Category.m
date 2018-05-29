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

    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    adcomps = [calendar components:kCFCalendarUnitYear |kCFCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:day];
    return [calendar dateByAddingComponents:adcomps toDate:self options:NSCalendarWrapComponents];
}

+ (NSDate *)firstDayInfoOfWeek {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    calendar.firstWeekday = 1;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    comps = [calendar components:kCFCalendarUnitYear | kCFCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:today];
    
    NSInteger weekDay = [comps weekday];
    NSInteger day = [comps day];
    NSInteger diffDay =  calendar.firstWeekday - weekDay;
    
    NSDateComponents *mondayComp = [calendar components: kCFCalendarUnitYear | kCFCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:today];
    [mondayComp setDay:day + diffDay];
    
    return [calendar dateFromComponents:mondayComp];
}


- (NSString *)day {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setDateFormat:@"dd"];
    return [formatter stringFromDate:self];
}

- (NSString *)month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyyMMdd"];
    [formatter setDateFormat:@"MM月"];
    return [formatter stringFromDate:self];
}

@end
