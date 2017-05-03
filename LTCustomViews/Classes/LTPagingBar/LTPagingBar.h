//
//  LTPagingBar.h
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/5/3.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTPagingBar;
@class LTPagingBarConfig;

@protocol LTPagingBarDelegate <NSObject>

/**
 选项卡, 选中某个索引, 从某个索引
 
 @param segmentBar 选项卡
 @param toIndex 选中的索引
 @param index 索引改变之前的值
 */
- (void)pagingBar:(LTPagingBar *)pagingBar didSelectedAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end

@interface LTPagingBar : UIView

/** 标题 */
@property (nonatomic, strong) NSArray *items;

/** 默认选中 */
@property (nonatomic, assign) NSInteger normalSelectIndex;

/** 代理 */
@property (nonatomic, weak) id<LTPagingBarDelegate> delegate;

/**
 配置默认信息
 */
- (void)setConfig:(LTPagingBarConfig *)config;

@end






















