//
//  XRCalendarFatherHeaderView.h
//  XRCalendarSets
//
//  Created by 上海羽博医学科技有限公司 on 2018/9/12.
//  Copyright © 2018年 brave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRCalendarFatherHeaderView : UICollectionReusableView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) void (^previousBlock)(void);
@property (nonatomic, copy) void (^nextBlock)(void);

@end
