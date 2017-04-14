//
//  LTSegmentBar.h
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/13.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTSegmentBar;
@class LTSegmentBarConfig;

@protocol LTSegmentBarDelegate <NSObject>

/**
 选项卡, 选中某个索引, 从某个索引
 
 @param segmentBar 选项卡
 @param toIndex 选中的索引
 @param index 索引改变之前的值
 */
- (void)segmentBar:(LTSegmentBar *)segmentBar didSelectedAtIndex:(NSInteger)toIndex fromIndex:(NSInteger)fromIndex;

@end


@interface LTSegmentBar : UIView

/** 选项 */
@property (nonatomic, strong) NSArray<NSString *> *items;

/** 默认选中 */
@property (nonatomic, assign) NSInteger normalSelectIndex;

/** 代理 */
@property (nonatomic, weak) id<LTSegmentBarDelegate> delegate;

/**
 设置配置
 */
- (void)setSegmentBarConfig:(LTSegmentBarConfig *)segmentBarConfig;

@end







































