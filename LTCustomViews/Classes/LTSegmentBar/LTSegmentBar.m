//
//  LTSegmentBar.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/13.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTSegmentBar.h"
#import "UIView+LTLayout.h"
#import "LTSegmentBarConfig.h"

@interface LTSegmentBar () <UIScrollViewDelegate>
{
    UIButton *_selectedBtn;
}

/** 按钮间最小距离 - 默认30 */
@property (nonatomic, assign) CGFloat minimumSpacing;

/** 内容上左下右距离 - 默认 (0, 30, 0, 30, 上下间距之和 以及 左右间距之和 均不能大于或等于本身高度, 否则分别 默认均为0) */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

/** 按钮数组 */
@property (nonatomic, strong) NSMutableArray<UIButton *> *itemBtns;

/** 滚动视图 */
@property (nonatomic, weak) UIScrollView *scrollView;

/** 指示器 */
@property (nonatomic, weak) UIView *indicatorView;

/** 子控制器 */
@property (nonatomic, strong) UIViewController *superViewController;

/** 配置 */
@property (nonatomic, strong) LTSegmentBarConfig *segmentBarConfig;

@end

@implementation LTSegmentBar

#pragma mark - < 构造方法 / 初始化方法 >

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpInit];
    }
    return self;
}

- (void)setUpInit
{
    _segmentBarConfig = [LTSegmentBarConfig defaultSegmentBarConfig];
    _normalSelectIndex = -1;
    _minimumSpacing = _segmentBarConfig.minimumSpacing;
    _contentEdgeInsets = _segmentBarConfig.contentEdgeInsets;
}

#pragma mark - < get方法 >

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = _segmentBarConfig.backgroundColor;
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)indicatorView
{
    if (!_indicatorView) {
        UIView *indicatorView = [[UIView alloc] init];
        indicatorView.height = 2;
        indicatorView.bottom = _segmentBarConfig.indicatorViewHeight;
        indicatorView.backgroundColor = _segmentBarConfig.indicatorViewColor;
        [self.scrollView addSubview:indicatorView];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (NSMutableArray<UIButton *> *)itemBtns
{
    if (!_itemBtns) {
        self.itemBtns = [NSMutableArray array];
    }
    return _itemBtns;
}

#pragma mark - < set方法 >

/**
 设置配置
 */
- (void)setSegmentBarConfig:(LTSegmentBarConfig *)segmentBarConfig
{
    _segmentBarConfig = segmentBarConfig;
    
    for (UIButton *btn in self.itemBtns) {
        [btn setTitleColor:segmentBarConfig.normalItemTextColor forState:(UIControlStateNormal)];
        [btn setTitleColor:segmentBarConfig.selectItemTextColor forState:(UIControlStateDisabled)];
        btn.titleLabel.font = segmentBarConfig.btnFont;
        btn.backgroundColor = segmentBarConfig.backgroundColor;
    }
    
    _minimumSpacing = segmentBarConfig.minimumSpacing;
    _contentEdgeInsets = segmentBarConfig.contentEdgeInsets;
    _scrollView.backgroundColor = segmentBarConfig.backgroundColor;
    _indicatorView.height = segmentBarConfig.indicatorViewHeight;
    _indicatorView.backgroundColor = segmentBarConfig.indicatorViewColor;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/**
 设置默认选项
 */
- (void)setNormalSelectIndex:(NSInteger)normalSelectIndex
{
    _normalSelectIndex = normalSelectIndex;
    
    if (self.itemBtns.count == 0 || normalSelectIndex < 0 || normalSelectIndex > self.itemBtns.count - 1) return;
    
    [self btnClickEvent:self.itemBtns[normalSelectIndex]];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/**
 设置选项卡
 */
- (void)setItems:(NSArray<NSString *> *)items
{
    _items = items;
    [self.itemBtns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.itemBtns.count) _normalSelectIndex = -1;
    [self.itemBtns removeAllObjects];
    
    for (int i = 0; i < items.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = _itemBtns.count;
        [btn setTitle:items[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:_segmentBarConfig.normalItemTextColor forState:(UIControlStateNormal)];
        [btn setTitleColor:_segmentBarConfig.selectItemTextColor forState:(UIControlStateDisabled)];
        btn.backgroundColor = _segmentBarConfig.backgroundColor;
        btn.titleLabel.font = _segmentBarConfig.btnFont;
        
        [btn addTarget:self action:@selector(btnClickEvent:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.scrollView addSubview:btn];
        [_itemBtns addObject:btn];
    }
    _selectedBtn = nil;
    if (_selectedBtn == nil && _normalSelectIndex > -1 && self.items.count != 0 && _normalSelectIndex < self.items.count) {
        [self btnClickEvent:self.itemBtns[_normalSelectIndex]];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

/**
 按钮点击事件
 */
- (void)btnClickEvent:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(segmentBar:didSelectedAtIndex:fromIndex:)]) {
        [self.delegate segmentBar:self didSelectedAtIndex:btn.tag fromIndex:_selectedBtn == nil ? -1 : _selectedBtn.tag];
    }
    
    _normalSelectIndex = btn.tag;
    
    self.indicatorView.hidden = NO;
    if (_selectedBtn == nil) self.indicatorView.centerX = btn.centerX;
    
    _selectedBtn.enabled = YES;
    btn.enabled = NO;
    _selectedBtn = btn;
    
    self.indicatorView.bottom = self.scrollView.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    
    
    CGFloat contentOffsetX = btn.centerX - self.scrollView.width * 0.5;
    if (contentOffsetX < self.contentEdgeInsets.left) {
        contentOffsetX = 0;
    }
    if (contentOffsetX > self.scrollView.contentSize.width - self.scrollView.width) {
        contentOffsetX = self.scrollView.contentSize.width - self.scrollView.width;
    }
    [self.scrollView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
}

#pragma mark - < 系统方法 >

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.items.count == 0) return;
    
    CGFloat top = self.contentEdgeInsets.top;
    CGFloat left = self.contentEdgeInsets.left;
    CGFloat bottom = self.contentEdgeInsets.bottom;
    CGFloat right = self.contentEdgeInsets.right;
    
    if (top + bottom >= self.scrollView.height) {
        top = 0;
        bottom = 0;
    }
    if (left + right >= self.width) {
        left = 0;
        right = 0;
    }
    
    CGFloat btnY = top;
    CGFloat btnH = self.height - top - bottom;
    
    CGFloat btnTotalWidth = 0;
    for (UIButton *btn in self.itemBtns) {
        [btn sizeToFit];
        
        btn.y = btnY;
        btn.height = btnH;
        btnTotalWidth += btn.width;
    }
    
    // 间距
    CGFloat spacing = (self.width - btnTotalWidth - left - right) / (self.itemBtns.count - 1);
    if (spacing < self.minimumSpacing) spacing = self.minimumSpacing;
    self.scrollView.bounces = spacing > self.minimumSpacing ? NO : YES;
    CGFloat btnX = left;
    
    for (int i = 0; i < _itemBtns.count; i++) {
        UIButton *btn = _itemBtns[i];
        btn.x = btnX;
        btnX += btn.width + spacing;
    }
    self.scrollView.contentSize = CGSizeMake(btnX - spacing + right, 0);
    
    if (_selectedBtn) {
        self.indicatorView.height = _segmentBarConfig.indicatorViewHeight;
        self.indicatorView.bottom = self.scrollView.height;
        self.indicatorView.width = _selectedBtn.width;
        self.indicatorView.centerX = _selectedBtn.centerX;
    }
    self.indicatorView.hidden = _selectedBtn == nil;
}







@end































