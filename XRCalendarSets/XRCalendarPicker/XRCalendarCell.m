//
//  XRCalendarCell.m
//  Calendar
//
//  Created by 邵勇 on 2018/1/30.
//  Copyright © 2018年 null. All rights reserved.
//

#import "XRCalendarCell.h"
#import "Masonry.h"

#import "NSDate+XRCategory.h"

@interface XRCalendarCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *festivalLabel;
@property (nonatomic, strong) UILabel *exchangeLabel;

@property (nonatomic, strong) UIImageView *disableImageView;

@end

@implementation XRCalendarCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    return self;
}


- (void)loadSubViews {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.festivalLabel = [[UILabel alloc] init];
    self.festivalLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.festivalLabel];
    
    self.exchangeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.exchangeLabel];
    
    self.disableImageView = [[UIImageView alloc] init];
    self.disableImageView.hidden = YES;
    self.disableImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    [self.contentView addSubview:self.disableImageView];
}

- (void)setDate:(NSDate *)date {
    [super setDate:date];
    
    self.titleLabel.text = date ? [NSString stringWithFormat:@"%ld", date.day] : @"";
    self.titleLabel.font = self.style.dateFont;
    self.disableImageView.hidden = self.state != XRCalendarItemDisableState;
    
    self.contentView.backgroundColor = self.state == XRCalendarItemSelectedState ? self.style.selectedBgColor : self.style.normalBgColor;
    
    if (self.style.showToday && [date isToday]) {
        self.titleLabel.text = @"今天";
        self.titleLabel.font = self.style.todayFont;
        self.titleLabel.textColor = self.state == XRCalendarItemSelectedState ? self.style.dateSelectedColor : self.style.todayColor;
    } else {
        self.titleLabel.textColor = self.state == XRCalendarItemSelectedState ? self.style.dateSelectedColor : self.style.dateNormalColor;
    }
    
    if (![date isWorkDay]) {
        self.titleLabel.textColor = self.state == XRCalendarItemSelectedState ? self.style.dateSelectedColor : self.style.dateWeekColor;
    }
}

- (void)setFestivalText:(NSString *)festivalText {
    [super setFestivalText:festivalText];
    
    self.festivalLabel.text = festivalText;
    
    self.festivalLabel.textColor = self.state == XRCalendarItemSelectedState ? self.style.festivalSelectedColor : self.style.festivalNormalColor;
    self.festivalLabel.font = self.style.festivalFont;
}

- (void)setExchangeType:(XRCalendarExchangeType)exchangeType {
    [super setExchangeType:exchangeType];
    
    switch (exchangeType) {
        case XRCalendarExchangeNoneType:
        {
            self.exchangeLabel.text = @"";
        }
            break;
        case XRCalendarExchangeRestType:
        {
            self.exchangeLabel.textColor = self.style.exchangeRestColor;
            self.exchangeLabel.text = @"休";
        }
            break;
        case XRCalendarExchangeWorkType:
        {
            self.exchangeLabel.textColor = self.style.exchangeWorkColor;
            self.exchangeLabel.text = @"班";
        }
            break;
        default:
            break;
    }
    
    self.exchangeLabel.font = self.style.exchangeFont;
    if (self.state == XRCalendarItemSelectedState) {
        self.exchangeLabel.textColor = self.style.exchangeSelectedColor;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.offset(0);
        make.height.width.equalTo(@15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.exchangeLabel.mas_bottom);
        make.left.right.offset(0);
    }];
    
    [self.festivalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(3);
    }];
    
    [self.disableImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}


@end
