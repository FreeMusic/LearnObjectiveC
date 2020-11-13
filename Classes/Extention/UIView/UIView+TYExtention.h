//
//  UIView+TYExtention.h
//  TanWinSAAS
//
//  Created by 吴高翔 on 2020/6/30.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapLabelClickBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TYExtention)

@property (nonatomic, assign) CGFloat lz_width;
@property (nonatomic, assign) CGFloat lz_height;
@property (nonatomic, assign) CGFloat xPoint;
@property (nonatomic, assign) CGFloat yPoint;
@property (nonatomic, assign, readonly) CGFloat bottomPoint;///
@property (nonatomic, assign, readonly) CGFloat rightPoint;///

//查找view所在的控制器
- (UIViewController*)viewController;

/// 查找导航控制器
- (UINavigationController *)navigationController;

/// UIView子控件设置圆角 贝塞尔曲线
/// @param radious 圆角大小
- (void)setCornerRadious:(CGFloat)radious;

/// 设置某些部分为圆角
/// @param radious 圆角角度
/// @param corners 需要设置为圆角的∠
- (void)setCornerRadious:(CGFloat)radious corners:(UIRectCorner)corners;

/// 设置一个View为圆形
- (void)setRoundRadious;

/// UIView子控件设置圆角 离屏渲染
/// @param radious 圆角大小
- (void)setApplyColoursCornerRadious:(CGFloat)radious;

/// View绘制渐变色
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param frame frame
- (void)drawGradientWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/// View绘制渐变色 (左到右）
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param frame frame
- (void)drawLeftToRightGradientWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/// View绘制渐变色
/// @param startColor 起始颜色
/// @param endColor 结束颜色
- (void)drawGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;
/// 绘制贝塞尔直线
/// @param start 起点
/// @param end 终点
/// @param strokeColor 线的颜色
/// @param height 线条高度
- (void)pathWithStart:(CGPoint)start end:(CGPoint)end strokeColor:(UIColor *)strokeColor height:(CGFloat)height;

/// 将一个View转化为UIImage
- (UIImage *)viewTransToUIImage;

/// 添加分割线 默认颜色
/// @param frame 分割线frame
- (void)addDividerlineWithFrame:(CGRect)frame;

/// 添加分割线 默认颜色
/// @param frame 分割线frame
- (UIView *)obtainDividerlineWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
