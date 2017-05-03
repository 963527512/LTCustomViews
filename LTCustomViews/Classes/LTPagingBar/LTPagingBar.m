//
//  LTPagingBar.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/5/3.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTPagingBar.h"
#import "UIView+LTLayout.h"
#import "LTPagingBarConfig.h"

@interface LTPagingBar ()

/** 指示器 */
@property (nonatomic, weak) UIView *indicatorView;

/** 按钮 */
@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;

/** 被选中的按钮 */
@property (nonatomic, strong) UIButton *selectedBtn;

/** <#content#> */
@property (nonatomic, strong) LTPagingBarConfig *config;

@end

@implementation LTPagingBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - < 设置 >

- (void)setup
{
    self.config = [LTPagingBarConfig defaultConfig];
}

#pragma mark - < 接口 >

/**
 配置默认信息
 */
- (void)setConfig:(LTPagingBarConfig *)config
{
    _config = config;

    for (UIButton *btn in self.btns) {
        [btn setTitleColor:config.normalBtnTextColor forState:(UIControlStateNormal)];
        [btn setTitleColor:config.selectedBtnTextColor forState:(UIControlStateDisabled)];
        btn.titleLabel.font = config.textFont;
    }
    
    self.indicatorView.backgroundColor = config.indicatorViewBackgroundColor;
    self.indicatorView.height = config.indicatorViewHeight;
    
    [self layoutIfNeeded];
    [self setNeedsLayout];
}

#pragma mark - < get >

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.backgroundColor = _config.indicatorViewBackgroundColor;
        [self addSubview:indicatorView];
        self.indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (NSMutableArray<UIButton *> *)btns
{
    if (!_btns) {
        self.btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

#pragma mark - < set >

- (void)setNormalSelectIndex:(NSInteger)normalSelectIndex
{
    if (_normalSelectIndex == normalSelectIndex) return;
    
    _normalSelectIndex = normalSelectIndex;
    
    if (!self.btns.count || normalSelectIndex >= self.btns.count || normalSelectIndex < 0) return;
    [self btnClick:self.btns[normalSelectIndex]];
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.btns = nil;
    
    for (int i = 0; i < items.count; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        
        [btn setTitle:items[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:_config.normalBtnTextColor forState:(UIControlStateNormal)];
        [btn setTitleColor:_config.selectedBtnTextColor forState:(UIControlStateDisabled)];
        btn.titleLabel.font = _config.textFont;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        btn.tag = i;
        [self addSubview:btn];
        [self.btns addObject:btn];
    }
    
    if (_normalSelectIndex >= 0) {
        [self btnClick:self.btns[_normalSelectIndex]];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)btnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(pagingBar:didSelectedAtIndex:fromIndex:)]) {
        [self.delegate pagingBar:self didSelectedAtIndex:sender.tag fromIndex:_selectedBtn.tag];
    }
    
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    _normalSelectIndex = sender.tag;
    
    self.indicatorView.height = _config.indicatorViewHeight;
    self.indicatorView.bottom = self.height;
    self.indicatorView.width = sender.width;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = sender.centerX;
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.btns.count == 0) return;
    
    CGFloat width = self.width / self.btns.count;
    
    CGFloat x = 0;
    CGFloat height = self.height;
    
    for (int i = 0; i < self.btns.count; i++) {
        self.btns[i].frame = CGRectMake(x + width * i, 0, width, height);
    }
    
    if (self.btns.count && _normalSelectIndex >= 0 && _normalSelectIndex < self.btns.count) {
        self.indicatorView.width = width;
        self.indicatorView.centerX = self.btns[_normalSelectIndex].centerX;
        self.indicatorView.height = _config.indicatorViewHeight;
        self.indicatorView.y = self.height - self.indicatorView.height;
    }
}

@end












































