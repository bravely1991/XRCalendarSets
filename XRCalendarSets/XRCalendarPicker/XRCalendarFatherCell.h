//
//  XRCalendarFatherCell.h
//  XRCalendarSets
//
//  Created by 上海羽博医学科技有限公司 on 2018/9/12.
//  Copyright © 2018年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XRCalendarPickStyle.h"

@interface XRCalendarFatherCell : UICollectionViewCell

@property (nonatomic, strong) XRCalendarPickStyle *style;

@property (nonatomic, assign) XRCalendarItemState state;

@property (nonatomic, assign) XRCalendarExchangeType exchangeType;

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) NSString *festivalText;

@end
