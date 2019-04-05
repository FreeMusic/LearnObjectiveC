//
//  UILabel+Extenion.h
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/4/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapLabelClick)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extenion)

/**
 生成Label，颜色自定义
 */
+ (UILabel *)LabelWithColor:(UIColor *)color andTextFont:(CGFloat)font andText:(NSString *)text addSubView:(UIView *)view;
/**
 生成Label，颜色自定义  增加点击手势
 */
+ (UILabel *)LabelWithColor:(UIColor *)color andTextFont:(CGFloat)font andText:(NSString *)text addSubView:(UIView *)view tapClick:(tapLabelClick)tapClick;
/**
 同一个label改变字体大小
 */
+ (void)ChangeSize:(NSString *)str andLabel:(UILabel *)label size:(CGFloat)size;
/**
 中间字体颜色的改变
 */
+ (void)ChangeColorString:(NSString *)str andLabel:(UILabel *)label andColor:(UIColor *)color;
/**
 *改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

@end

NS_ASSUME_NONNULL_END
