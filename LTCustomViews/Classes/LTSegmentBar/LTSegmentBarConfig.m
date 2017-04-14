//
//  LTSegmentBarConfig.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/14.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTSegmentBarConfig.h"

@implementation LTSegmentBarConfig

+ (instancetype)defaultSegmentBarConfig
{
    LTSegmentBarConfig *segmentBarConfig = [LTSegmentBarConfig new];
    
    segmentBarConfig.normalItemTextColor = [UIColor blackColor];
    segmentBarConfig.selectItemTextColor = [UIColor redColor];
    segmentBarConfig.indicatorViewColor = [UIColor redColor];
    segmentBarConfig.backgroundColor = [UIColor whiteColor];
    segmentBarConfig.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    segmentBarConfig.minimumSpacing = 30;
    segmentBarConfig.indicatorViewHeight = 2;
    segmentBarConfig.btnFont = [UIFont systemFontOfSize:15];
    return segmentBarConfig;
}

@end
