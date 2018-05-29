//
//  XRCalendarCell.m
//  Calendar
//
//  Created by 邵勇 on 2018/1/30.
//  Copyright © 2018年 null. All rights reserved.
//

#import "XRCalendarCell.h"
#import "Masonry.h"

@interface XRCalendarCell ()


@end

@implementation XRCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    return self;
}


- (void)loadSubViews {
    self.titleBtn = [[UIButton alloc] init];
    self.titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self.titleBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [self.titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self.titleBtn setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
    self.titleBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.titleBtn];
}

- (void)setText:(NSString *)text {
    _text = text;
    [self.titleBtn setTitle:text forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.titleBtn.selected = selected;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];
}


@end
