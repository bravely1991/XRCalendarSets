//
//  XRCalendarPickStyle.h
//  XRCalendarSets
//
//  Created by 上海羽博医学科技有限公司 on 2018/9/11.
//  Copyright © 2018年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XRCalendarExchangeType) {
    XRCalendarExchangeNoneType  = 1,   // 正常
    XRCalendarExchangeWorkType  = 2,   // 班
    XRCalendarExchangeRestType  = 3,   // 休
};

typedef NS_ENUM(NSUInteger, XRCalendarItemState) {
    XRCalendarItemNormalState   = 1,   // 正常
    XRCalendarItemSelectedState = 2,   // 选中
    XRCalendarItemDisableState  = 3,   // 禁用
};

@interface XRCalendarPickStyle : NSObject

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) BOOL showToday;
@property (nonatomic, strong) UIColor *todayColor;
@property (nonatomic, strong) UIFont *todayFont;

@property (nonatomic, strong) UIColor *dateNormalColor;
@property (nonatomic, strong) UIColor *dateSelectedColor;
@property (nonatomic, strong) UIColor *dateWeekColor;
@property (nonatomic, strong) UIFont *dateFont;

@property (nonatomic, strong) UIColor *festivalNormalColor;
@property (nonatomic, strong) UIColor *festivalSelectedColor;
@property (nonatomic, strong) UIFont *festivalFont;

@property (nonatomic, strong) UIColor *exchangeRestColor;
@property (nonatomic, strong) UIColor *exchangeWorkColor;
@property (nonatomic, strong) UIColor *exchangeSelectedColor;
@property (nonatomic, strong) UIFont *exchangeFont;

@property (nonatomic, strong) UIColor *selectedBgColor;
@property (nonatomic, strong) UIColor *normalBgColor;

@end
