//
//  LTSegmentBarViewController.h
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/14.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTSegmentBar;
@interface LTSegmentBarViewController : UIViewController

/** 分页控件 */
@property (nonatomic, strong) LTSegmentBar *segmentBar;

/**
 这是控制器
 
 @param superViewController 父控制器, 子控制器的View大小 == 父控制器的View大小
 @param subViewControllers 子控制器数组
 */
- (void)setupWithItems:(NSArray<NSString *> *)items subViewControllers:(NSArray<UIViewController *> *)subViewControllers;

@end
