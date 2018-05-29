//
//  XRCanlendarPickerViewController.m
//  XRCalendarSets
//
//  Created by 邵勇 on 2018/5/29.
//  Copyright © 2018年 brave. All rights reserved.
//

#import "XRCanlendarPickerViewController.h"
#import "XRCalendarPicker.h"

@interface XRCanlendarPickerViewController ()

@property (nonatomic, strong) XRCalendarPicker *calendar;

@end

@implementation XRCanlendarPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.calendar = [[XRCalendarPicker alloc] initWithFrame:CGRectMake(0, 0, 320, 350)];
    self.calendar.center = self.view.center;
    self.calendar.today = [NSDate date];
    self.calendar.date = [NSDate date];
    [self.view addSubview:self.calendar];
    
    [self.calendar setDidSelectedDate:^(NSString *strDate) {
        NSLog(@"strDate:%@",strDate);
    }];
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
