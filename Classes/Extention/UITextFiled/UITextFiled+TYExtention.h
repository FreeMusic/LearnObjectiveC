//
//  UITextFiled+TYExtention.h
//  TanWinSAAS
//
//  Created by 碳银TW on 2020/4/28.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

//用户输入监听回调
typedef void(^UITextFieldEditValueChangeBlock)(UITextField * _Nonnull textField);

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (TYExtention)

@property (nonatomic, copy) UITextFieldEditValueChangeBlock editValueBlock;
@property (nonatomic, assign) int inputMax;//输入框输入的最大长度
@property (nonatomic, copy) NSString *inputRules;//输入规则限制

/// 创建UITextField
/// @param placeHolder 占位文字
/// @param textColor 输入字体颜色
/// @param font 输入字体大小
/// @param subView 父视图
+ (UITextField *)textFiledWithPlaceHolder:(NSString *)placeHolder
                                textColor:(UIColor *)textColor
                                     font:(int)font
                               addSubView:(UIView *)subView;

/// 对UITextFiled输入框的输入长度和规则做限制 并回调输入显示的结果
/// @param inputMax 输入框输入的最大长度
/// @param inputRules 输入规则限制
/// @param editValueBlock 输入回调
- (void)setTextFieldInputMax:(int)inputMax inputRules:(NSString *)inputRules editValueBlock:(UITextFieldEditValueChangeBlock)editValueBlock;

@end

NS_ASSUME_NONNULL_END
