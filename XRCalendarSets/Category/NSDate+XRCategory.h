//
//  NSDate+Category.h
//  XRCalendarWeekView
//
//  Created by brave on 2018/5/26.
//  Copyright © 2018年 brave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XRCategory)

+ (NSDate *)firstDayInfoOfWeek;
- (NSDate *)nextDay:(NSInteger)day;
- (NSDate *)firstDayOfThisMonth;
- (NSInteger)firstWeekdayInThisMonth;
- (NSInteger)totaldaysInThisMonth;
- (NSInteger)totaldaysInMonth;

- (NSString *)dayStringWithFormat:(NSString *)dayFormat;
- (NSString *)monthStringWithFormat:(NSString *)dayFormat;

/**
 *  该日期是否是今天
 */
- (BOOL)isToday;
@property (nonatomic, assign, readonly) BOOL isWorkDay;    ///< 是否周一到周五
@property (nonatomic, assign, readonly) NSInteger day;
@property (nonatomic, assign, readonly) NSInteger month;
@property (nonatomic, assign, readonly) NSInteger year;
@property (nonatomic, assign, readonly) NSInteger weekday; ///< 星期

- (BOOL)isEqualDay:(NSDate *)otherDate;
- (NSDate *)lastMonth;
- (NSDate*)nextMonth;

@end
