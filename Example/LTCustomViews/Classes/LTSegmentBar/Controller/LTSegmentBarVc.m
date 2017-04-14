//
//  LTSegmentBarVc.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/14.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTSegmentBarVc.h"
#import "LTSegmentBar.h"
#import "UIView+LTLayout.h"
#import "LTSubViewController.h"
#import "LTSegmentBarViewController.h"
#import "LTSegmentBarConfig.h"

@interface LTSegmentBarVc ()

/** 分页 */
@property (nonatomic, weak) LTSegmentBarViewController *segmentBarVc;

@end

@implementation LTSegmentBarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    LTSegmentBarViewController *segmentBarVc = [LTSegmentBarViewController new];
    
    segmentBarVc.segmentBar.frame = CGRectMake(0, 100, kScreen_width, 40);
    [self.view addSubview:segmentBarVc.segmentBar];
    
    segmentBarVc.view.frame = CGRectMake(0, 140, kScreen_width, self.view.height - 140);
    [self.view addSubview:segmentBarVc.view];
    [self addChildViewController:segmentBarVc];
    self.segmentBarVc = segmentBarVc;
    
    LTSubViewController *vc1 = [LTSubViewController new];
    
    LTSubViewController *vc2 = [LTSubViewController new];
    
    LTSubViewController *vc3 = [LTSubViewController new];
    
    LTSubViewController *vc4 = [LTSubViewController new];
    
    LTSubViewController *vc5 = [LTSubViewController new];
    
    LTSubViewController *vc6 = [LTSubViewController new];
    
    LTSubViewController *vc7 = [LTSubViewController new];
    
    LTSubViewController *vc8 = [LTSubViewController new];
    
    LTSubViewController *vc9 = [LTSubViewController new];
    
    LTSubViewController *vc10 = [LTSubViewController new];
    
    LTSubViewController *vc11 = [LTSubViewController new];
    
    LTSubViewController *vc12 = [LTSubViewController new];
    
    NSArray *vcs = @[vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9, vc10, vc11, vc12];
    
    NSArray *items = @[@"音乐", @"会馆", @"下载", @"视宴", @"啪啪", @"喝啊", @"音乐", @"会馆", @"下载", @"视宴", @"啪啪", @"喝啊"];
    
    [segmentBarVc setupWithItems:items subViewControllers:vcs];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LTSegmentBarConfig *segmentBarConfig = [LTSegmentBarConfig new];
    segmentBarConfig.normalItemTextColor = [UIColor blueColor];
    segmentBarConfig.selectItemTextColor = [UIColor orangeColor];
    segmentBarConfig.indicatorViewColor = [UIColor purpleColor];
    segmentBarConfig.backgroundColor = [UIColor yellowColor];
    segmentBarConfig.contentEdgeInsets = UIEdgeInsetsMake(0, 40, 0, 40);
    segmentBarConfig.minimumSpacing = 50;
    segmentBarConfig.indicatorViewHeight = 5;
    segmentBarConfig.btnFont = [UIFont systemFontOfSize:20];
    
    [self.segmentBarVc.segmentBar setSegmentBarConfig:segmentBarConfig];
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
