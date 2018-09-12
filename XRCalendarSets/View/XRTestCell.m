//
//  XRTestCell.m
//  XRCalendarSets
//
//  Created by 上海羽博医学科技有限公司 on 2018/9/12.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRTestCell.h"

#import "NSDate+XRCategory.h"

#import "Masonry.h"

@interface XRTestCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation XRTestCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    return self;
}

- (void)setDate:(NSDate *)date {
    [super setDate:date];
    
    self.titleLabel.text = date ? [NSString stringWithFormat:@"%ld", date.day] : @"";
}

@end
