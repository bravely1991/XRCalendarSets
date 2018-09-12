//
//  XRCalendarHeaderView.m
//  Calendar
//
//  Created by 邵勇 on 2018/1/31.
//  Copyright © 2018年 null. All rights reserved.
//

#import "XRCalendarHeaderView.h"
#import "Masonry.h"

@interface XRCalendarHeaderView ()

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UIButton *previousBtn;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIView *weekView;

@property (nonatomic, strong) NSArray *weekArray;

@end

@implementation XRCalendarHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        self.weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    self.monthLabel = [[UILabel alloc] init];
    self.monthLabel.font = [UIFont systemFontOfSize:17];
    self.monthLabel.textColor = [UIColor whiteColor];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.monthLabel];
    
    self.previousBtn = [[UIButton alloc] init];
    [self.previousBtn setImage:[UIImage imageNamed:@"bt_previous"] forState:UIControlStateNormal];
    [self.previousBtn addTarget:self action:@selector(previousBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.previousBtn];
    
    self.nextBtn = [[UIButton alloc] init];
    [self.nextBtn setImage:[UIImage imageNamed:@"bt_next"] forState:UIControlStateNormal];
    [self.nextBtn addTarget:self action:@selector(nextBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextBtn];
    
    self.weekView = [[UIView alloc] init];
    self.weekView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.weekView];
    
    CGFloat itemWidth = self.bounds.size.width / 7;
    for (NSInteger i=0; i<self.weekArray.count; i++) {
        CGFloat x = itemWidth * i;
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, 5, itemWidth, 20)];
        dayLabel.font = [UIFont systemFontOfSize:17];
        dayLabel.textColor = [UIColor redColor];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        dayLabel.text= self.weekArray[i];
        [self.weekView addSubview:dayLabel];
    }
}

- (void)previousBtnEvent {
    if (self.previousBlock) {
        self.previousBlock();
    }
}

- (void)nextBtnEvent {
    if (self.nextBlock) {
        self.nextBlock();
    }
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.monthLabel.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.top.equalTo(@5);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.previousBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.height.equalTo(@20);
        make.top.equalTo(@5);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.width.height.equalTo(@20);
        make.top.equalTo(@5);
    }];
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.mas_centerY);
        make.bottom.equalTo(@0);
    }];
}

@end
