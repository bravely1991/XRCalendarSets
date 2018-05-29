//
//  XRCalendarPicker.m
//  Calendar
//
//  Created by 邵勇 on 2018/1/30.
//  Copyright © 2018年 null. All rights reserved.
//

#import "XRCalendarPicker.h"
#import "XRCalendarHeaderView.h"
#import "XRCalendarCell.h"


@interface XRCalendarPicker ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XRCalendarPicker


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightTextColor];
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    CGFloat itemWidth = self.bounds.size.width / 7;
    CGFloat itemHeight = (self.bounds.size.height-60) / 5;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, 60);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = NO;
    [self.collectionView registerClass:[XRCalendarCell class]forCellWithReuseIdentifier:@"XRCalendarCell"];
    [self.collectionView registerClass:[XRCalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"XRCalendarHeaderView"];
    [self addSubview:self.collectionView];
    
    [self addSwipe];
}

- (void)addSwipe {
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}

- (void)reloadData {
    [self.collectionView reloadData];
}


- (void)setDate:(NSDate *)date {
    _date = date;
    [self.collectionView reloadData];
}

- (void)previouseAction {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastMonth:self.date];
    } completion:nil];
}

- (void)nexAction {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextMonth:self.date];
    } completion:nil];
}

#pragma mark - date

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    XRCalendarHeaderView *headerView = [XRCalendarHeaderView viewWithCollectionView:collectionView forIndexPath:indexPath];
    headerView.title = [NSString stringWithFormat:@"%.2ld-%li",(long)[self month:self.date],(long)[self year:self.date]];
    headerView.previousBlock = ^{
        [self previouseAction];
    };
    headerView.nextBlock = ^{
        [self nexAction];
    };
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7 * 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XRCalendarCell" forIndexPath:indexPath];
    
    NSInteger daysInThisMonth = [self totaldaysInMonth:self.date];
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:self.date];
    
    if (indexPath.row < firstWeekday || indexPath.row > firstWeekday + daysInThisMonth - 1) {
        cell.text = @"";
    }else{
        NSInteger day = indexPath.row - firstWeekday + 1;
        cell.text = [NSString stringWithFormat:@"%li",(long)day];
        
        NSInteger today_year = [self year:self.today];
        NSInteger today_month = [self month:self.today];
        NSInteger today_day = [self day:self.today];
        
        NSInteger date_year = [self year:self.date];
        NSInteger date_month = [self month:self.date];
        NSInteger date_day = [self day:self.date];
        if (today_year == date_year && today_month == date_month && today_day == date_day && day == today_day) {
            NSLog(@"isEqualToDate");
            cell.titleBtn.highlighted = YES;
        }else {
            cell.titleBtn.highlighted = NO;
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCalendarCell *cell = (XRCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
    
    NSInteger date_year = [self year:self.date];
    NSInteger date_month = [self month:self.date];
    NSInteger date_day = cell.text.intValue;
    
    NSString *strDate = [NSString stringWithFormat:@"%04d-%02d-%02d",(int)date_year,(int)date_month,(int)date_day];
    if (self.didSelectedDate) {
        self.didSelectedDate(strDate);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCalendarCell *cell = (XRCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
}




//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(@0);
//    }];
//    
//}

@end
