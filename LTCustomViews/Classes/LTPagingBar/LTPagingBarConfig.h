//
//  LTPagingBarConfig.h
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/5/3.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LTPagingBarConfig : NSObject

/** 默认文字颜色 */
@property (nonatomic, strong) UIColor *normalBtnTextColor;
/** 选中文字颜色 */
@property (nonatomic, strong) UIColor *selectedBtnTextColor;
/** 文字字体 */
@property (nonatomic, strong) UIFont *textFont;
/** 指示器高度 */
@property (nonatomic, assign) CGFloat indicatorViewHeight;
/** 指示器颜色色 */
@property (nonatomic, strong) UIColor *indicatorViewBackgroundColor;

+ (instancetype)defaultConfig;

@end
