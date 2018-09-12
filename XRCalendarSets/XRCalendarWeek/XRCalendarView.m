//
//  XRCalendarView.m
//  AutoPlus
//
//  Created by brave on 2018/5/26.
//  Copyright © 2018年 autoplus. All rights reserved.
//

#import "XRCalendarView.h"
#import "Masonry.h"
#import "NSDate+XRCategory.h"
#import "XRWeekDayView.h"


@interface XRCalendarView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *monthLabel;

@property (nonatomic, strong) UIView *weekView;

@property (nonatomic, strong) NSDate *firstDayOfWeek;
@property (nonatomic, strong) NSMutableArray *weekDayArray;
@property (nonatomic, copy) NSString *month;

@end

@implementation XRCalendarView

+ (instancetype)calendarView {
    XRCalendarView *calendarView = [[XRCalendarView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    
    return calendarView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self getWeekData];

        [self loadSubViews];
        
    }
    return self;
}

- (void)loadSubViews {
    self.monthLabel = [[UILabel alloc] init];
    self.monthLabel.textAlignment = NSTextAlignmentCenter;
    self.monthLabel.textColor = [UIColor redColor];
    self.monthLabel.text = self.month;
    [self addSubview:self.monthLabel];
    
    self.leftBtn = [[UIButton alloc] init];
    [self.leftBtn setImage:[UIImage imageNamed:@"bt_previous"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(leftBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.leftBtn];
    
    self.rightBtn = [[UIButton alloc] init];
    [self.rightBtn setImage:[UIImage imageNamed:@"bt_next"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.rightBtn];
    
    self.weekView = [[UIView alloc] init];
    [self addSubview:self.weekView];
    
    NSArray *weekArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    for (NSInteger i=0; i<7; i++) {
        XRWeekDayView *weekDayView = [[XRWeekDayView alloc] init];
        weekDayView.tag = 1000 + i;
        weekDayView.week = weekArray[i];
        weekDayView.day = self.weekDayArray[i];
        [self.weekView addSubview:weekDayView];
    }
}

- (void)getWeekData {
    self.firstDayOfWeek = [NSDate firstDayInfoOfWeek];
    NSLog(@"first day:%@",self.firstDayOfWeek);
    self.month = [self.firstDayOfWeek monthStringWithFormat:@"MM月"];
    
    self.weekDayArray = [NSMutableArray array];
    for (NSInteger i=0; i<7; i++) {
        NSDate *date = [self.firstDayOfWeek nextDay:i];
        NSString *day =  [date dayStringWithFormat:@"dd"];
        [self.weekDayArray addObject:day];
    }
}

- (void)reloadData {
    self.month = [self.firstDayOfWeek monthStringWithFormat:@"MM月"];
    
    NSLog(@"%@,%@",self.month, self.firstDayOfWeek);
    
    self.weekDayArray = [NSMutableArray array];
    for (NSInteger i=0; i<7; i++) {
        NSDate *date = [self.firstDayOfWeek nextDay:i];
        NSString *day =  [date dayStringWithFormat:@"dd"];
        [self.weekDayArray addObject:day];
    }
    
    for (NSInteger i=0; i<7; i++) {
        XRWeekDayView *weekDayView = [self.weekView viewWithTag: 1000 + i];
        weekDayView.day = self.weekDayArray[i];
    }
    self.monthLabel.text = self.month;
}

- (void)leftBtnEvent {
    self.firstDayOfWeek = [self.firstDayOfWeek nextDay:-7];
    [self reloadData];
}

- (void)rightBtnEvent {
    self.firstDayOfWeek = [self.firstDayOfWeek nextDay:7];
    [self reloadData];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@30);
        make.top.equalTo(@0);
    }];
    
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.left.equalTo(@20);
        make.bottom.equalTo(@-10);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@30);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@-10);
    }];
    
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@60);
        make.bottom.equalTo(@0);
        make.left.equalTo(self.leftBtn.mas_right).offset(20);
        make.right.equalTo(self.rightBtn.mas_left).offset(-20);
    }];
    
    [self.weekView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.weekView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.weekView.mas_centerY);
    }];
}


@end
