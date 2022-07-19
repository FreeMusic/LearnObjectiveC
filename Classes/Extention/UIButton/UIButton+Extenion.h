//
//  UIButton+Extenion.h
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/4/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>
//按钮的点击事件 block
typedef void(^ButtonActionBlock)(UIButton *button);

/**
 枚举按钮的背景颜色
 - ButtonNormalColor: 背景色主色调（混合） 可以交互
 - ButtonGrayColor: 灰色按钮 不可交互
 - ButtonWhiteColor: 白色背景按钮 可交互
 - ButtonClearColor: 透明色 可交互
 -ButtonYellowColor: 黄色 用于发验证码按钮 默认可交互
 -ButtonDarkColor: 主色调 深色
 -ButtonTintColor: 主色调 浅色
 */
typedef NS_ENUM(NSUInteger, SXYButtonBackColor){
    ButtonNormalColor,
    ButtonGrayColor,
    ButtonWhiteColor,
    ButtonClearColor,
    ButtonYellowColor,
    ButtonNormalColorWithLine,
    ButtonWhiteColorWithLine,
    ButtonBlueColor,
    ButtonDarkColor,
    ButtonTintColor,
    ButtonBlackTitleNormalBackColor,
    ButtonGrayColorWithLine,
};


NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extenion)

@property(nonatomic, assign) SXYButtonBackColor color;

@property (nonatomic, assign) NSTimeInterval xy_eventInterval;///时间间隔

/**
 *  适用于 有背景颜色 有圆角 的按钮 点击事件可以在block回调中处理
 */
+ (UIButton *)ButtonWithTitle:(NSString *)title ButtonBackColor:(SXYButtonBackColor)buttonBackColor CornerRadius:(CGFloat)radius addSubView:(UIView *)subView buttonActionBlock:(ButtonActionBlock)buttonActionBlock;

@end

NS_ASSUME_NONNULL_END
