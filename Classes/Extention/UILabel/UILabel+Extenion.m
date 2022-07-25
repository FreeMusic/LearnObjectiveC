//
//  UILabel+Extenion.m
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/4/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "UILabel+Extenion.h"
#import <objc/runtime.h>

//runtime用键取值 此处定义一个键  键的类型随意 int 什么都可以  但是char类型占用内存最小
static char labelActionKey;

@implementation UILabel (Extenion)

/**
 生成Label，颜色自定义
 */
+ (UILabel *)LabelWithColor:(UIColor *)color andTextFont:(CGFloat)font andText:(NSString *)text addSubView:(UIView *)view{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.text = text;
    [view addSubview:label];
    
    return label;
}

/**
 生成Label，颜色自定义  增加点击手势
 */
+ (UILabel *)LabelWithColor:(UIColor *)color andTextFont:(CGFloat)font andText:(NSString *)text addSubView:(UIView *)view tapClick:(tapLabelClick)tapClick{
    UILabel *label = [UILabel LabelWithColor:color andTextFont:font andText:text addSubView:view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:label action:@selector(tapClick:)];
    objc_setAssociatedObject(tap, &labelActionKey, tapClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tap];
    
    return label;
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    tapLabelClick block = objc_getAssociatedObject(tap, &labelActionKey);
    
    block();
}
/**
 同一个label改变字体大小
 */
+ (void)ChangeSize:(NSString *)str andLabel:(UILabel *)label size:(CGFloat)size{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size*m6Scale] range:[label.text rangeOfString:str]];
    label.attributedText = string;
}
/**
 *改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space{
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}
/**
 中间字体颜色的改变
 */
+ (void)ChangeColorString:(NSString *)str andLabel:(UILabel *)label andColor:(UIColor *)color{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:label.text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:[label.text rangeOfString:str]];
    label.attributedText = string;
}


@end
