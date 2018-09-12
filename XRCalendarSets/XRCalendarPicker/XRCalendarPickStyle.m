//
//  XRCalendarPickStyle.m
//  XRCalendarSets
//
//  Created by 上海羽博医学科技有限公司 on 2018/9/11.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRCalendarPickStyle.h"

@implementation XRCalendarPickStyle

- (instancetype)init {
    if (self = [super init]) {
        
        self.headerHeight = 60;
        
        self.showToday = NO;
        self.todayColor = [UIColor blueColor];
        self.todayFont = [UIFont systemFontOfSize:16];
        
        self.dateNormalColor = [UIColor blackColor];
        self.dateSelectedColor = [UIColor whiteColor];
        self.dateWeekColor = [UIColor redColor];
        self.dateFont = [UIFont systemFontOfSize:15];
        
        self.festivalNormalColor = [UIColor grayColor];
        self.festivalSelectedColor = [UIColor whiteColor];
        self.festivalFont = [UIFont systemFontOfSize:9];
        
        self.exchangeRestColor = [UIColor redColor];
        self.exchangeWorkColor = [UIColor lightGrayColor];
        self.exchangeSelectedColor = [UIColor whiteColor];
        self.exchangeFont = [UIFont systemFontOfSize:8];
    
        self.selectedBgColor = [UIColor blueColor];
        self.normalBgColor = [UIColor whiteColor];
    }
    return self;
}

@end
 
