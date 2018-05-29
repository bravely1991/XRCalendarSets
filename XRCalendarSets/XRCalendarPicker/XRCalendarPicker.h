//
//  XRCalendarPicker.h
//  Calendar
//
//  Created by 邵勇 on 2018/1/30.
//  Copyright © 2018年 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRCalendarPicker : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *today;

- (void)reloadData;

@property (nonatomic, copy) void (^didSelectedDate)(NSString *strDate);


@end
