//
//  LTShufflingView.h
//  Pods
//
//  Created by 冰凌天 on 2017/4/12.
//
//

#import <UIKit/UIKit.h>

typedef void (^LTClickEvent)(NSInteger index);
typedef void (^LTLoadImageBlock)(UIImageView *imageView, NSInteger index);
@interface LTShufflingView : UIView

/** 滚动时间间隔 默认 - 3秒 */
@property (nonatomic, assign) NSInteger interval;

/** 图片总数  默认 - 0 */
@property (nonatomic, assign) NSInteger totalCount;

/** 点击事件 */
@property (nonatomic, copy) LTClickEvent clickEvent;

/** 图片缩放模式 默认 - UIViewContentModeScaleAspectFill */
@property (nonatomic, assign) UIViewContentMode contentMode;

/** pageControl距离控件底部的距离 默认 - 20 */
@property (nonatomic, assign) CGFloat pageControlBottomInSuperView;

+ (instancetype)shufflingView;

- (void)setTotalCount:(NSInteger)totalCount loadImage:(LTLoadImageBlock)loadImage;

/**
 调整图片位置
 */
- (void)adjustPicturePosition;

@end
