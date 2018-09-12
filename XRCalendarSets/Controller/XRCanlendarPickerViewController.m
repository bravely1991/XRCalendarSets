//
//  XRCanlendarPickerViewController.m
//  XRCalendarSets
//
//  Created by 邵勇 on 2018/5/29.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRCanlendarPickerViewController.h"
#import "XRCalendarPicker.h"

#import "NSDate+XRCategory.h"

#import "XRTestCell.h"

@interface XRCanlendarPickerViewController () <XRCalendarPickerDelegate>

@property (nonatomic, strong) XRCalendarPicker *calendar;

@end

@implementation XRCanlendarPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    XRCalendarPickStyle *style = [[XRCalendarPickStyle alloc] init];
    style.selectedBgColor = [UIColor redColor];
    style.headerHeight = 60;
    // 1.测试自定义cell
    style.cellClass = [XRTestCell class];
    
    self.calendar = [[XRCalendarPicker alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
    self.calendar.delegate = self;
    self.calendar.style = style;
    self.calendar.center = self.view.center;
    [self.view addSubview:self.calendar];
    
    [self.calendar setDidSelectedDate:^(NSDate *selectedDate) {
        NSLog(@"selectedDate: %@",selectedDate);
    }];
}

#pragma mark - XRCalendarPickerDelegate
- (XRCalendarExchangeType)calendarPicker:(XRCalendarPicker *)picker exchangeTypeWithDate:(NSDate *)date {
    if ([[[NSDate date] nextDay:11] isEqualDay:date] || [[[NSDate date] nextDay:12] isEqualDay:date] || [[[NSDate date] nextDay:13] isEqualDay:date]) {
        return XRCalendarExchangeRestType;
    } else if ([[[NSDate date] nextDay:14] isEqualDay:date] || [[[NSDate date] nextDay:15] isEqualDay:date]) {
        return XRCalendarExchangeWorkType;
    } else {
        return XRCalendarExchangeNoneType;
    }
}

- (NSString *)calendarPicker:(XRCalendarPicker *)picker festivalWithDate:(NSDate *)date {
    if ([[[NSDate date] nextDay:11] isEqualDay:date]) {
        return @"中秋节";
    } else {
        return @"";
    }
}

- (XRCalendarItemState)calendarPicker:(XRCalendarPicker *)picker itemStateWithDate:(NSDate *)date {
    if ([date isEqualDay:[[NSDate date] nextDay:5]]) {
        return XRCalendarItemDisableState;
    } else {
        return XRCalendarItemNormalState;
    }
}

@end
