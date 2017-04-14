//
//  LTSegmentBarConfig.h
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/14.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSegmentBarConfig : NSObject

/** 默认按钮文字颜色 */
@property (nonatomic, strong) UIColor *normalItemTextColor;
/** 选中按钮文字颜色 */
@property (nonatomic, strong) UIColor *selectItemTextColor;
/** 细线颜色 */
@property (nonatomic, strong) UIColor *indicatorViewColor;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *backgroundColor;
/** 四边边距 */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
/** 最小间距 */
@property (nonatomic, assign) CGFloat minimumSpacing;
/** 指示器高度 */
@property (nonatomic, assign) CGFloat indicatorViewHeight;
/** 按钮字体 */
@property (nonatomic, strong) UIFont *btnFont;

/**
 默认配置
 */
+ (instancetype)defaultSegmentBarConfig;

@end






