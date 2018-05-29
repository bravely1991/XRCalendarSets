//
//  NSDate+Category.h
//  XRCalendarWeekView
//
//  Created by brave on 2018/5/26.
//  Copyright © 2018年 brave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

- (NSDate *)nextDay:(NSInteger)day;
- (NSString *)day;
@end
