//
//  XRCalendarPicker.h
//  Calendar
//
//  Created by 邵勇 on 2018/1/30.
//  Copyright © 2018年 null. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XRCalendarPickStyle.h"

@class XRCalendarPicker;

@protocol XRCalendarPickerDelegate <NSObject>

@optional
- (XRCalendarExchangeType)calendarPicker:(XRCalendarPicker *)picker exchangeTypeWithDate:(NSDate *)date;
- (XRCalendarItemState)calendarPicker:(XRCalendarPicker *)picker itemStateWithDate:(NSDate *)date;
- (NSString *)calendarPicker:(XRCalendarPicker *)picker festivalWithDate:(NSDate *)date;

@end

@interface XRCalendarPicker : UIView

@property (nonatomic, copy) void (^didSelectedDate)(NSDate *selectedDate);

@property (nonatomic, strong) NSDate *selectedDate;

@property (nonatomic, strong) XRCalendarPickStyle *style;

@property (nonatomic, weak) id delegate;

- (void)reloadData;

@end
