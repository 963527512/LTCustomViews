//
//  LTSegmentBarViewController.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/14.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTSegmentBarViewController.h"
#import "UIView+LTLayout.h"
#import "LTSegmentBar.h"

@interface LTSegmentBarViewController () <UIScrollViewDelegate, LTSegmentBarDelegate>

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LTSegmentBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LTSegmentBar *)segmentBar
{
    if (!_segmentBar) {
        self.segmentBar = [[LTSegmentBar alloc] init];
        _segmentBar.delegate = self;
    }
    return _segmentBar;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.scrollView.width, 0);
}

/**
 这是控制器
 
 @param superViewController 父控制器, 子控制器的View大小 == 父控制器的View大小
 @param subViewControllers 子控制器数组
 */
- (void)setupWithItems:(NSArray<NSString *> *)items subViewControllers:(NSArray<UIViewController *> *)subViewControllers
{
    NSAssert(items.count == subViewControllers.count, @"选项卡数量与子控制器数量不一致");
    
    self.segmentBar.items = items;
    
    // 移除所有子控制器
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 将自控制器添加到父控制器上
    for (UIViewController *vc in subViewControllers) {
        [self addChildViewController:vc];
    }
    
    // 设置滚动视图滚动范围
    self.scrollView.contentSize = CGSizeMake(subViewControllers.count * self.scrollView.width, 0);
    
    self.segmentBar.normalSelectIndex = 0;
}

/**
 选项卡, 选中某个索引, 从某个索引
 
 @param segmentBar 选项卡
 @param toIndex 选中的索引
 @param index 索引改变之前的值
 */
- (void)segmentBar:(LTSegmentBar *)segmentBar didSelectedAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex
{
    if (self.childViewControllers.count == 0) return;
    self.scrollView.contentOffset = CGPointMake(toIndex * self.scrollView.width, 0);
    [self contentViewAddSubViewsWithToIndex:toIndex];
}

/**
 添加子控制器的View到contentView
 */
- (void)contentViewAddSubViewsWithToIndex:(NSInteger)toIndex
{
    UIViewController *vc = self.childViewControllers[toIndex];
    if (vc.view.superview != self.scrollView) {
        [vc.view removeFromSuperview];
        
        vc.view.frame = CGRectMake(self.scrollView.width * toIndex, 0, self.scrollView.width, self.scrollView.height);
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.scrollView addSubview:vc.view];
    }
}

#pragma mark - < UIScrollViewDelegate >

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    self.segmentBar.normalSelectIndex = index;
}

@end



































