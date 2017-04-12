//
//  LTMenueView.h
//  Pods
//
//  Created by 冰凌天 on 2017/4/12.
//
//

#import <UIKit/UIKit.h>

typedef void (^ LTLoadBtnData)(UIButton *btn, NSInteger index);
typedef void (^ LTBtnClick)(NSInteger index);

@interface LTMenueView : UIScrollView

/**
 构造方法
 */
+ (instancetype)menueView;

/**
 设置控件
 
 @param number 控件宽度内显示的按钮个数
 @param totalCount 按钮的总数
 @param margin 按钮间距
 @param contentEdgeInsets 内容的上下左右间距, 均不能为负值
 @param loadBtnData 加载按钮数据的block
 @param btnClick 按钮点击回调block
 */
- (void)setAccordingNumber:(CGFloat)number
                totalCount:(NSInteger)totalCount
                    margin:(CGFloat)margin
         contentEdgeInsets:(UIEdgeInsets)contentEdgeInsets
               loadBtnData:(LTLoadBtnData)loadBtnData
                  btnClick:(LTBtnClick)btnClick;


@end
