//
//  LTTimeSelectorViewController.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/15.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTTimeSelectorViewController.h"
#import "LTTimeSelectorView.h"
@interface LTTimeSelectorViewController ()

/** 选择器 */
@property (nonatomic, weak) LTTimeSelectorView *timeSelectorView;

@end

@implementation LTTimeSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LTTimeSelectorView *timeSelectorView = [LTTimeSelectorView timeSelectorView];
    
    [timeSelectorView showWithDate:[NSDate date] minimumDate:nil maximumDate:nil sureCompletion:^(NSDate *date) {
        NSLog(@"%@", date);
    }];
    self.timeSelectorView = timeSelectorView;
    
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
