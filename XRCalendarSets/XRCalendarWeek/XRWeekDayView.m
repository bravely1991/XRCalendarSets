//
//  XRWeekDayView.m
//  XRCalendarSets
//
//  Created by 邵勇 on 2018/5/29.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRWeekDayView.h"
#import "Masonry.h"

@interface XRWeekDayView ()

@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) UILabel *dayLabel;

@end

@implementation XRWeekDayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubviews];
    }
    return self;
}

- (void)loadSubviews {
    self.weekLabel = [[UILabel alloc] init];
    self.weekLabel.textColor = [UIColor redColor];
    self.weekLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.weekLabel];
    
    self.dayLabel = [[UILabel alloc] init];
    self.dayLabel.textColor = [UIColor darkTextColor];
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dayLabel];

}

- (void)setWeek:(NSString *)week {
    _week = week;
    self.weekLabel.text = week;
}

- (void)setDay:(NSString *)day {
    _day = day;
    self.dayLabel.text = day;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@20);
        make.top.equalTo(@0);
    }];
    
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@20);
    }];
    
}

@end
