//
//  UIView+TYExtention.m
//  TanWinSAAS
//
//  Created by 吴高翔 on 2020/6/30.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "UIView+TYExtention.h"

@implementation UIView (TYExtention)

- (void)setLZ_width:(CGFloat)LZ_width {
  CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, LZ_width, self.frame.size.height);
  self.frame = frame;
}
- (CGFloat)lz_width {
  return self.frame.size.width;
}

- (void)setLZ_height:(CGFloat)LZ_height {
  CGRect frame = self.frame;
  frame.size.height = LZ_height;
  self.frame = frame;
}

- (CGFloat)lz_height {
  return self.frame.size.height;
}

- (void)setXPoint:(CGFloat)xPoint{
  CGRect frame = self.frame;
  frame.origin.x = xPoint;
  self.frame = frame;
}

- (CGFloat)xPoint{
  return self.frame.origin.x;
}

- (void)setYPoint:(CGFloat)yPoint{
  CGRect frame = self.frame;
  frame.origin.y = yPoint;
  self.frame = frame;
}

- (CGFloat)yPoint{
  return self.frame.origin.y;
}

- (CGFloat)bottomPoint {
  return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)rightPoint {
  return self.frame.origin.x + self.frame.size.width;
}

//查找view所在的控制器
- (UIViewController*)viewController {
  for (UIView* next = [self superview]; next; next = next.superview) {
    UIResponder* nextResponder = [next nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
      return (UIViewController*)nextResponder;
    }
  }
  return nil;
}


/// 查找导航控制器
- (UINavigationController *)navigationController {
  return [self viewController].navigationController;
}

/// UIView子控件设置圆角
/// @param radious 圆角大小
- (void)setCornerRadious:(CGFloat)radious{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    CAShapeLayer *cornerLayer = [CAShapeLayer layer];
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radious];
    cornerLayer.path = cornerPath.CGPath;
    cornerLayer.frame = self.bounds;
    self.layer.mask = cornerLayer;
  });
}

/// 设置某些部分为圆角
/// @param radious 圆角角度
/// @param corners 需要设置为圆角的∠
- (void)setCornerRadious:(CGFloat)radious corners:(UIRectCorner)corners{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    CAShapeLayer *cornerLayer = [CAShapeLayer layer];
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radious, radious)];
    cornerLayer.path = cornerPath.CGPath;
    cornerLayer.frame = self.bounds;
    self.layer.mask = cornerLayer;
  });
}

/// 设置一个View为圆形
- (void)setRoundRadious{
  [self setCornerRadious:self.frame.size.height/2];
  //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  //        CAShapeLayer *cornerLayer = [CAShapeLayer layer];
  //        UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width/2];
  //        cornerLayer.path = cornerPath.CGPath;
  //        cornerLayer.frame = self.bounds;
  //        self.layer.mask = cornerLayer;
  //    });
}

/// UIView子控件设置圆角 离屏渲染
/// @param radious 圆角大小
- (void)setApplyColoursCornerRadious:(CGFloat)radious{
  self.layer.cornerRadius = radious;
  self.layer.masksToBounds = YES;
}

/// View绘制渐变色
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param frame frame
- (void)drawGradientWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor{
  CAGradientLayer * gradientLayer = [CAGradientLayer layer];
  gradientLayer.frame = frame;
  gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
  gradientLayer.startPoint = CGPointMake(0, 0);
  gradientLayer.endPoint = CGPointMake(0, 1);
  gradientLayer.locations = @[@0,@1];
  [self.layer addSublayer:gradientLayer];
}

/// View绘制渐变色 (左到右）
/// @param startColor 起始颜色
/// @param endColor 结束颜色
/// @param frame frame
- (void)drawLeftToRightGradientWithFrame:(CGRect)frame startColor:(UIColor *)startColor endColor:(UIColor *)endColor {
  //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  CAGradientLayer * gradientLayer = [CAGradientLayer layer];
  gradientLayer.frame = frame;
  gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
  gradientLayer.startPoint = CGPointMake(0, 0);
  gradientLayer.endPoint = CGPointMake(1, 0);
  gradientLayer.locations = @[@0,@1];
  [self.layer addSublayer:gradientLayer];
  //    });
}



/// View绘制渐变色
/// @param startColor 起始颜色
/// @param endColor 结束颜色
- (void)drawGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    [self.layer addSublayer:gradientLayer];
  });
}

/// 绘制贝塞尔直线
/// @param start 起点
/// @param end 终点
/// @param strokeColor 线的颜色
/// @param height 线条高度
- (void)pathWithStart:(CGPoint)start end:(CGPoint)end strokeColor:(UIColor *)strokeColor height:(CGFloat)height{
  UIBezierPath *path = [UIBezierPath bezierPath];
  path.lineWidth = height;
  [path moveToPoint:start];//设置起点
  [path addLineToPoint:end];//设置终点
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  shapeLayer.strokeColor = strokeColor.CGColor;
  shapeLayer.path = path.CGPath;
  [self.layer addSublayer:shapeLayer];
}

/// 将一个View转化为UIImage
- (UIImage *)viewTransToUIImage {
  
  UIImage *imageRet = [[UIImage alloc]init];
  //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
  UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, [UIScreen mainScreen].scale);
  [self.layer renderInContext:UIGraphicsGetCurrentContext()];
  imageRet = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return imageRet;
  
}

///// 添加分割线 默认颜色
///// @param frame 分割线frame
//- (void)addDividerlineWithFrame:(CGRect)frame{
//  UIView *line = [[UIView alloc] initWithFrame:frame];
//  line.backgroundColor = LINE_COLOR;
//  [self addSubview:line];
//}
//
///// 添加分割线 默认颜色
///// @param frame 分割线frame
//- (UIView *)obtainDividerlineWithFrame:(CGRect)frame{
//  UIView *line = [[UIView alloc] initWithFrame:frame];
//  line.backgroundColor = LINE_COLOR;
//  [self addSubview:line];
//  return line;
//}

//截图
- (UIImage *)screenShot {
    UIGraphicsImageRendererFormat *format = [UIGraphicsImageRendererFormat defaultFormat];
    UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithSize:self.frame.size format:format];
    return [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [self.layer renderInContext:rendererContext.CGContext];
    }];
}

@end
