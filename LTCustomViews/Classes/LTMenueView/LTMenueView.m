//
//  LTMenueView.m
//  Pods
//
//  Created by 冰凌天 on 2017/4/12.
//
//

#import "LTMenueView.h"
#import "LTUpDownButton.h"

@interface LTMenueView ()

/** 控件宽度内显示多少个按钮 */
@property (nonatomic, assign) CGFloat number;

/** 按钮总数 */
@property (nonatomic, assign) NSInteger totalCount;

/** 赋值block */
@property (nonatomic, copy) LTLoadBtnData loadBtnData;

/** 赋值block */
@property (nonatomic, copy) LTBtnClick btnClick;

/** 按钮间距 */
@property (nonatomic, assign) CGFloat margin;

/** 上左下右间距 默认 (0, 0, 0, 0) */
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;

@end

@implementation LTMenueView

/**
 构造方法
 */
+ (instancetype)menueView
{
    return [[self alloc] init];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

/**
 设置总数
 */
- (void)setTotalCount:(NSInteger)totalCount
{
    _totalCount = totalCount;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < totalCount; i++) {
        
        LTUpDownButton *btn = [[LTUpDownButton alloc] init];
        if (self.loadBtnData) {
            self.loadBtnData(btn, i);
        }
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i + 100;
        [self addSubview:btn];
    }
}


- (void)btnClick:(LTUpDownButton *)btn
{
    if (self.btnClick) {
        self.btnClick(btn.tag - 100);
    }
}


/**
 设置控件
 
 @param number 控件宽度内显示的按钮个数
 @param totalCount 按钮的总数
 @param margin 按钮间距
 @param contentEdgeInsets 内容的上下左右间距
 @param loadBtnData 加载按钮数据的block
 @param btnClick 按钮点击回调block
 */
- (void)setAccordingNumber:(CGFloat)number
                totalCount:(NSInteger)totalCount
                    margin:(CGFloat)margin
         contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
               loadBtnData:(LTLoadBtnData)loadBtnData
                  btnClick:(LTBtnClick)btnClick;
{
    self.number = number;
    self.loadBtnData = loadBtnData;
    self.totalCount = totalCount;
    self.btnClick = btnClick;
    self.margin = margin;
    self.contentEdgeInsets = contentEdgeInsets;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_totalCount <= 0) return;
    
    CGFloat top = self.contentEdgeInsets.top;
    CGFloat left = self.contentEdgeInsets.left;
    CGFloat bottom = self.contentEdgeInsets.bottom;
    CGFloat right = self.contentEdgeInsets.right;
    
    // 控件显示范围内 间距个数
    NSInteger marginCount = (_number > (NSInteger)_number ? (NSInteger)_number + 1 : _number) - 1;
    // 控件显示范围内 按钮总宽度
    CGFloat btnTotalWidth = CGRectGetWidth(self.frame) - left - marginCount * _margin - ((marginCount + 1) > _number ? 0 : right);
    // 按钮高度
    CGFloat btnHeight = CGRectGetHeight(self.frame) - top - bottom;
    
    // 按钮总宽度 < 0 或者 高度 < 0, 不显示按钮
    if (btnTotalWidth < 0 || btnHeight < 0 || top < 0 || left < 0 || bottom < 0 || right < 0 || _number <= 0 || _margin <= 0) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.hidden = YES;
        }];
        return;
    }
    
    CGFloat btnX = left;
    CGFloat btnY = top;
    CGFloat btnWidth = btnTotalWidth / _number;
    
    for (int i = 0; i < _totalCount; i++) {
        [self viewWithTag:i + 100].frame = CGRectMake(btnX + (btnWidth + _margin) * i, btnY, btnWidth, btnHeight);
    }
    CGFloat contentWidth = _totalCount * btnWidth + (_totalCount - 1) * _margin + left + right;
    self.contentSize = CGSizeMake(contentWidth, 0);
}


@end





































