//
//  XRCalendarHeaderView.h
//  Calendar
//
//  Created by 邵勇 on 2018/1/31.
//  Copyright © 2018年 null. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRCalendarHeaderView : UICollectionReusableView

+ (instancetype)viewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^previousBlock)(void);
@property (nonatomic, copy) void (^nextBlock)(void);


@end
