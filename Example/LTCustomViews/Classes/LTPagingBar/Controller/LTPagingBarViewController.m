//
//  LTPagingBarViewController.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/5/3.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTPagingBarViewController.h"
#import "LTPagingBar.h"
#import "LTPagingBarConfig.h"
@interface LTPagingBarViewController () <LTPagingBarDelegate>

/** <#content#> */
@property (nonatomic, strong) LTPagingBar *bar;

@end

@implementation LTPagingBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    LTPagingBar *bar = [[LTPagingBar alloc] initWithFrame:CGRectMake(0, 100, kScreen_width, 40)];
    bar.delegate = self;
    bar.items = @[@"申请", @"变更", @"音乐", @"图书"];
    bar.normalSelectIndex = 0;
    bar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bar];
    
    self.bar = bar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    LTPagingBarConfig *config = [LTPagingBarConfig new];
    config.normalBtnTextColor = [UIColor redColor];
    config.selectedBtnTextColor = [UIColor purpleColor];
    config.indicatorViewBackgroundColor = [UIColor purpleColor];
    config.textFont = [UIFont systemFontOfSize:20];
    config.indicatorViewHeight = 5;
    [self.bar setConfig:config];
}

#pragma mark - < LTPagingBarDelegate >

/**
 选项卡, 选中某个索引, 从某个索引
 
 @param segmentBar 选项卡
 @param toIndex 选中的索引
 @param index 索引改变之前的值
 */
- (void)pagingBar:(LTPagingBar *)pagingBar didSelectedAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    NSLog(@"%zd - %zd", fromIndex, toIndex);
}


@end




