//
//  LTUpDownButton.m
//  Pods
//
//  Created by 冰凌天 on 2017/4/12.
//
//

#import "LTUpDownButton.h"

@implementation LTUpDownButton

@synthesize radio = _radio;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0] forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (CGFloat)radio
{
    return _radio > 0 ? _radio : 0.7;
}

- (void)setRadio:(CGFloat)radio
{
    _radio = radio;
    [self setNeedsLayout];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * self.radio, contentRect.size.width, contentRect.size.height * (1 - self.radio));
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * self.radio);
}

@end




































