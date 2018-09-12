//
//  NSDate+Category.m
//  XRCalendarWeekView
//
//  Created by brave on 2018/5/26.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

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

- (NSDate *)firstDayOfThisMonth {
    NSUInteger days = -self.day + 1;
    return [self nextDay:days];
}

/**
 *  该日期是否是今天
 */
- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (NSDate *)nextDay:(NSInteger)day {
    NSTimeInterval daySecond = 60*60*24*day;
    NSDate *newDate = [self initWithTimeInterval:daySecond sinceDate:self];
    return newDate;
}

- (NSString *)dayStringWithFormat:(NSString *)dayFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dayFormat];
    return [formatter stringFromDate:self];
}

- (NSString *)monthStringWithFormat:(NSString *)dayFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dayFormat];
    return [formatter stringFromDate:self];
}

- (NSInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components day];
}

- (NSInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components month];
}

- (NSInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    return [components year];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (BOOL)isWorkDay {
    return !(self.weekday == 7 || self.weekday == 1);
}

- (NSInteger)firstWeekdayInThisMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (BOOL)isEqualDay:(NSDate *)otherDate {
    NSInteger day = self.day;
    NSInteger month = self.month;
    NSInteger year = self.year;
    
    NSInteger otherDay = otherDate.day;
    NSInteger otherMonth = otherDate.month;
    NSInteger otherYear = otherDate.year;
    
    return (day == otherDay) && (month == otherMonth) && (year == otherYear);
}

- (NSInteger)totaldaysInThisMonth {
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth {
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate*)nextMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

@end
