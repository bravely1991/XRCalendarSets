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

#import "NSDate+Category.h"

@interface XRCalendarPicker ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSDate *date;

@end

@implementation XRCalendarPicker


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightTextColor];
        self.date = [NSDate date];
        self.selectedDate = self.date;
        self.style = [[XRCalendarPickStyle alloc] init];
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    CGFloat itemWidth = self.bounds.size.width / 7;
    CGFloat itemHeight = (self.bounds.size.height-self.style.headerHeight) / 6;
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    [self.layout setScrollDirection:UICollectionViewScrollDirectionVertical];

    self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, self.style.headerHeight);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
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

- (void)setStyle:(XRCalendarPickStyle *)style {
    _style = style;
    
    CGFloat itemWidth = self.bounds.size.width / 7;
    CGFloat itemHeight = (self.bounds.size.height - self.style.headerHeight) / 6;
    self.layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    self.layout.headerReferenceSize = CGSizeMake(self.bounds.size.width, self.style.headerHeight);
}

#pragma mark - 翻页
- (void)previouseAction {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self.date lastMonth];
    } completion:nil];
}

- (void)nexAction {
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self.date nextMonth];
    } completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    XRCalendarHeaderView *headerView = [XRCalendarHeaderView viewWithCollectionView:collectionView forIndexPath:indexPath];
    headerView.title = [NSString stringWithFormat:@"%.2ld-%li",(long)[self.date month],(long)[self.date year]];
    headerView.previousBlock = ^{
        [self previouseAction];
    };
    headerView.nextBlock = ^{
        [self nexAction];
    };
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger daysInThisMonth = [self.date totaldaysInMonth];
    NSInteger firstWeekday = [self.date firstWeekdayInThisMonth];
    if ((daysInThisMonth + firstWeekday) > 7 * 5) {
        return 7 * 6;
    } else {
        return 7 * 5;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XRCalendarCell" forIndexPath:indexPath];
    cell.style = self.style;
    
    NSInteger daysInThisMonth = [self.date totaldaysInMonth];
    NSInteger firstWeekday = [self.date firstWeekdayInThisMonth];
    
    if (indexPath.row < firstWeekday || indexPath.row > firstWeekday + daysInThisMonth - 1) {
        cell.state = XRCalendarItemNormalState;
        cell.date = nil;
        cell.festivalText = @"";
        cell.exchangeType = XRCalendarExchangeNoneType;
    } else {
        NSInteger days = indexPath.row - firstWeekday;
        NSDate *date = [[self.date firstDayOfThisMonth] nextDay:days];
        
        if ([date isEqualToDate:self.selectedDate]) {
            cell.state = XRCalendarItemSelectedState;
        } else {
            if ([self.delegate respondsToSelector:@selector(calendarPicker:itemStateWithDate:)]) {
                cell.state = [self.delegate calendarPicker:self itemStateWithDate:date];
            } else {
                cell.state = XRCalendarItemNormalState;
            }
        }
        
        cell.date = date;
        
        if ([self.delegate respondsToSelector:@selector(calendarPicker:festivalWithDate:)]) {
            cell.festivalText = [self.delegate calendarPicker:self festivalWithDate:date];
        } else {
            cell.festivalText = @"";
        }
        
        if ([self.delegate respondsToSelector:@selector(calendarPicker:exchangeTypeWithDate:)]) {
            cell.exchangeType = [self.delegate calendarPicker:self exchangeTypeWithDate:date];
        } else {
            cell.exchangeType = XRCalendarExchangeNoneType;
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XRCalendarCell *cell = (XRCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell.date isEqualToDate:self.selectedDate] || cell.state == XRCalendarItemDisableState) return;
    
    if (self.didSelectedDate && cell.date) {
        self.selectedDate = cell.date;
        [self.collectionView reloadData];
        self.didSelectedDate(cell.date);
    }
}

@end
