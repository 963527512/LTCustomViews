//
//  LTTimeSelectorView.m
//  Laver_Client
//
//  Created by 徐伯文 on 17/3/25.
//  Copyright © 2017年 郑州小刀计算机有限公司. All rights reserved.
//  时间选择器

#import "LTTimeSelectorView.h"

@interface LTTimeSelectorView () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewBottomConstraint;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

/** 取消按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

/** 最小时间 */
@property (nonatomic, strong) NSDate *minimumDate;
/** 最大时间 */
@property (nonatomic, strong) NSDate *maximumDate;

/** 确定按钮点击回调 */
@property (nonatomic, copy) void (^ sureCompletion)(NSDate *date);

@end

@implementation LTTimeSelectorView

+ (instancetype)timeSelectorView
{
    NSBundle *currentBundle = [NSBundle bundleForClass:self];
    return [currentBundle loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - < set方法 >

- (void)setCancelBtnTitle:(NSString *)cancelBtnTitle
{
    _cancelBtnTitle = cancelBtnTitle;
    [self.cancelBtn setTitle:self.cancelBtnTitle forState:(UIControlStateNormal)];
}

- (void)setCancelBtnTextColor:(UIColor *)cancelBtnTextColor
{
    _cancelBtnTextColor = cancelBtnTextColor;
    [self.cancelBtn setTitleColor:self.cancelBtnTextColor forState:(UIControlStateNormal)];
}

- (void)setCancelBtnFont:(UIFont *)cancelBtnFont
{
    _cancelBtnFont = cancelBtnFont;
    self.cancelBtn.titleLabel.font = self.cancelBtnFont;
}


- (void)setSureBtnTitle:(NSString *)sureBtnTitle
{
    _sureBtnTitle = sureBtnTitle;
    [self.sureBtn setTitle:self.sureBtnTitle forState:(UIControlStateNormal)];
}

- (void)setSureBtnTextColor:(UIColor *)sureBtnTextColor
{
    _sureBtnTextColor = sureBtnTextColor;
    [self.sureBtn setTitleColor:self.sureBtnTextColor forState:(UIControlStateNormal)];
}

- (void)setSureBtnFont:(UIFont *)sureBtnFont
{
    _sureBtnFont = sureBtnFont;
    self.sureBtn.titleLabel.font = self.sureBtnFont;
}

#pragma mark - < 私有方法 >

- (void)tapClick
{
    [self dismissWithCompletion:nil];
}

- (void)dismissWithCompletion:(void (^ __nullable)(BOOL finished))completion
{
    self.backViewBottomConstraint.constant = -self.backView.frame.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (completion) {
            completion(finished);
        }
    }];
}

#pragma mark - < set方法 >

- (void)setMinimumDate:(NSDate *)minimumDate
{
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate
{
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = maximumDate;
}

#pragma mark - < 点击事件 >

- (IBAction)cancelBtnClick:(id)sender {
    [self dismissWithCompletion:nil];
}

- (IBAction)sureBtnClick:(id)sender {
    [self dismissWithCompletion:^(BOOL finished) {
        if (self.sureCompletion) {
            self.sureCompletion(self.datePicker.date);
        }
    }];
}


#pragma mark - < public method >

- (void)showWithDate:(NSDate *)date minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate sureCompletion:(void (^)(NSDate *date))sureCompletion
{
    if (self.superview) [self removeFromSuperview];
    
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    self.frame = window.bounds;
    [self layoutIfNeeded];
    self.sureCompletion = sureCompletion;
    self.datePicker.date = date;
    self.minimumDate = minimumDate;
    self.maximumDate = maximumDate;
    [window addSubview:self];
    self.backViewBottomConstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}

+ (void)showWithDate:(NSDate *)date minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate sureCompletion:(void (^)(NSDate *date))sureCompletion
{
    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
    
    LTTimeSelectorView *timeSelectorView = [LTTimeSelectorView timeSelectorView];;
    timeSelectorView.frame = window.bounds;
    [timeSelectorView layoutIfNeeded];
    
    timeSelectorView.sureCompletion = sureCompletion;
    timeSelectorView.datePicker.date = date;
    timeSelectorView.minimumDate = minimumDate;
    timeSelectorView.maximumDate = maximumDate;
    
    [window addSubview:timeSelectorView];
    
    timeSelectorView.backViewBottomConstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [timeSelectorView layoutIfNeeded];
        timeSelectorView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }];
}

#pragma mark - < UIGestureRecognizerDelegate >

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return [touch.view isEqual:self];
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end







































