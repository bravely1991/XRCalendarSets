//
//  XRCalendarCell.h
//  Calendar
//
//  Created by 邵勇 on 2018/1/30.
//  Copyright © 2018年 null. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XRCalendarPickStyle.h"

@interface XRCalendarCell : UICollectionViewCell

@property (nonatomic, strong) XRCalendarPickStyle *style;

@property (nonatomic, assign) XRCalendarItemState state;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *festivalText;
@property (nonatomic, assign) XRCalendarExchangeType exchangeType;

@end
