//
//  XRCalendarWeekViewController.m
//  XRCalendarSets
//
//  Created by 邵勇 on 2018/5/29.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRCalendarWeekViewController.h"
#import "XRCalendarView.h"

@interface XRCalendarWeekViewController ()

@property (nonatomic, strong) XRCalendarView *calendarWeekView;

@end

@implementation XRCalendarWeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.calendarWeekView = [XRCalendarView calendarView];
    self.calendarWeekView.center = self.view.center;
    [self.view addSubview:self.calendarWeekView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
