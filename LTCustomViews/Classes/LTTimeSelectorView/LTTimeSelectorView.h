//
//  LTTimeSelectorView.h
//  Laver_Client
//
//  Created by 徐伯文 on 17/3/25.
//  Copyright © 2017年 郑州小刀计算机有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTTimeSelectorView : UIView

/** 取消按钮文字 */
@property (nonatomic, copy) NSString *cancelBtnTitle;
/** 取消按钮文字颜色 */
@property (nonatomic, strong) UIColor *cancelBtnTextColor;
/** 取消按钮文字大小 */
@property (nonatomic, strong) UIFont *cancelBtnFont;

/** 确定按钮文字 */
@property (nonatomic, copy) NSString *sureBtnTitle;
/** 确定按钮文字颜色 */
@property (nonatomic, strong) UIColor *sureBtnTextColor;
/** 确定按钮文字大小 */
@property (nonatomic, strong) UIFont *sureBtnFont;

+ (instancetype)timeSelectorView;

- (void)showWithDate:(NSDate *)date minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate sureCompletion:(void (^)(NSDate *date))sureCompletion;

+ (void)showWithDate:(NSDate *)date minimumDate:(NSDate *)minimumDate maximumDate:(NSDate *)maximumDate sureCompletion:(void (^)(NSDate *date))sureCompletion;

@end
