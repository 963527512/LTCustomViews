//
//  LTPagingBarConfig.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/5/3.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTPagingBarConfig.h"

@implementation LTPagingBarConfig

+ (instancetype)defaultConfig
{
    LTPagingBarConfig *config = [LTPagingBarConfig new];
    config.normalBtnTextColor = [UIColor blackColor];
    config.selectedBtnTextColor = [UIColor blueColor];
    config.textFont = [UIFont systemFontOfSize:14];
    config.indicatorViewHeight = 2;
    config.indicatorViewBackgroundColor = [UIColor blueColor];
    return config;
}

@end
