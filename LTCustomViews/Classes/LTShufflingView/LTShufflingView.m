//
//  LTShufflingView.m
//  Pods
//
//  Created by 冰凌天 on 2017/4/12.
//
//

#import "LTShufflingView.h"
#import "LTTimer.h"

@interface LTShufflingView () <UIScrollViewDelegate>
{
    NSInteger _currentPage;
}

/** 图片 */
@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageViews;

/** 分页控件 */
@property (nonatomic, weak) UIScrollView *scrollView;

/** 分页控件 */
@property (nonatomic, weak) UIPageControl *pageControl;

/** 定时器 */
@property (nonatomic, weak) LTTimer *scrollTimer;

@end

@implementation LTShufflingView

#pragma mark - < 构造方法 >

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _interval = 3;
        _contentMode = UIViewContentModeScaleAspectFit;
        _pageControlBottomInSuperView = 20;
    }
    return self;
}

#pragma mark - < 接口 >

+ (instancetype)shufflingView
{
    return [[LTShufflingView alloc] init];
}

- (void)setTotalCount:(NSInteger)totalCount loadImage:(LTLoadImageBlock)loadImage
{
    _totalCount = totalCount;
    
    [self.imageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.imageViews removeAllObjects];
    
    
    // 当图片总数不等于1时, 实际创建图片数量 = 总数量 * 3, 图片总数为 1 时, 实际创建图片为 1
    NSInteger imageViewCount = totalCount != 1 ? totalCount * 3 : 1;
    
    // 实际创建图片数量
    for (int i = 0; i < imageViewCount; i++) {
        // 创建图片, 并设置frame
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.scrollView.frame) * i, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.userInteractionEnabled = YES;
        // 添加到滚动视图
        [self.scrollView addSubview:imageView];
        // 与父控件等宽高比例
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        // 图片内容缩放模式
        imageView.contentMode = _contentMode;
        // 添加到图片数组
        [self.imageViews addObject:imageView];
        
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToLink:)]];
        
        // 使用block, 在外界对图片进行操作
        if (loadImage) {
            // 使用余数, 找到对应的下标
            loadImage(imageView, i % totalCount);
        }
    }
    
    // 当图片总数小于等于1时, 隐藏分页控件
    self.pageControl.hidden = totalCount <= 1;
    // 分页控件 页码数量为 图片总数
    self.pageControl.numberOfPages = totalCount;
    // 设置当前页码为0
    self.pageControl.currentPage = 0;
    
    // 这是滚动区域为 实际创建图片数 * 宽度
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * imageViewCount, 0);
    // 设置当前页码
    _currentPage = imageViewCount == 1 ? 0 : totalCount;
    // 滚动视图偏移量 为 滚动视图宽度 * 实际图片数量(图片数量为1时, 不偏移)
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * _currentPage, 0);
    
    
    // 实际图片数量 > 1 时 执行定时器
    if (imageViewCount > 1) {
        [self scrollTimer];
    }else {
        // 否则 移除定时器
        [self removeScrollTimer];
    }
    [self setNeedsLayout];
}

/**
 调整图片位置
 */
- (void)adjustPicturePosition
{
    CGFloat width = self.scrollView.frame.size.width;
    NSInteger index = (NSInteger)(self.scrollView.contentOffset.x / width + 0.5);
    [self.scrollView setContentOffset:CGPointMake(index * width, 0) animated:YES];
}

#pragma mark - < 私有方法 >

/**
 轻拍手势
 */
- (void)jumpToLink:(UITapGestureRecognizer *)gesture
{
    if (self.clickEvent) {
        NSInteger index = (NSInteger)(self.scrollView.contentOffset.x / self.scrollView.frame.size.width + 0.5);
        self.clickEvent(index % _totalCount);
    }
}

/**
 自动滚至下一页
 */
- (void)autoScrollNextPage
{
    NSInteger page = _currentPage + 1;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * page, 0) animated:YES];
}

#pragma mark - < geter seter >

- (void)setPageControlBottomInSuperView:(CGFloat)pageControlBottomInSuperView
{
    _pageControlBottomInSuperView = pageControlBottomInSuperView;
    [self setNeedsLayout];
}

- (void)setContentMode:(UIViewContentMode)contentMode
{
    _contentMode = contentMode;
    for (UIImageView *imageView in self.imageViews) {
        imageView.contentMode = contentMode;
    }
    [self setNeedsLayout];
}

- (LTTimer *)scrollTimer
{
    if (!_scrollTimer) {
        self.scrollTimer = [LTTimer scheduledTimerWithTimeInterval:_interval target:self selector:@selector(autoScrollNextPage) userInfo:nil repeats:YES];
    }
    return _scrollTimer;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (NSMutableArray<UIImageView *> *)imageViews
{
    if (!_imageViews) {
        self.imageViews = [NSMutableArray array];
    }
    return _imageViews;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}


/**
 移除定时器
 */
- (void)removeScrollTimer
{
    [_scrollTimer invalidate];
    _scrollTimer = nil;
}

#pragma mark - < 系统方法 >

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControl.center = self.scrollView.center;
    CGRect frame = self.pageControl.frame;
    frame.origin.y = CGRectGetHeight(self.frame) - _pageControlBottomInSuperView - CGRectGetHeight(self.pageControl.frame);
    self.pageControl.frame = frame;
}

#pragma mark - < UIScrollViewDelegate >

/**
 用手开始滑动时, 移除定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeScrollTimer];
}

/**
 松手后调用
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.imageViews.count > 1) {
        [self scrollTimer];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = CGRectGetWidth(self.scrollView.frame);
    CGFloat index = self.scrollView.contentOffset.x / width;
    self.pageControl.currentPage = (NSInteger)(index + 0.5) % _totalCount;
}

- (void)caculateCurrentPage:(UIScrollView *)scrollView
{
    if (scrollView == nil) return;
    if (self.totalCount == 0) return;
    if (self.totalCount == 1) return;
    
    NSInteger min = _totalCount;
    NSInteger max = _totalCount * 2;
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page % _totalCount;
    
    if (page < min || page > max) {
        page = min + page % _totalCount;
        [scrollView setContentOffset:CGPointMake(page * scrollView.frame.size.width, 0)];
    }
    _currentPage = page;
}

- (void)dealloc
{
    [self removeScrollTimer];
}

@end





























