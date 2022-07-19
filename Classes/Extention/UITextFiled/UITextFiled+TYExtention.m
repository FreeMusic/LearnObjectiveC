//
//  UITextFiled+TYExtention.m
//  TanWinSAAS
//
//  Created by 乐逍遥 on 2020/4/28.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "UITextFiled+TYExtention.h"
#import <objc/runtime.h>

static char UITextFieldEditKey;
static char UITextFieldInputRulesKey;

@interface UITextField ()<UITextFieldDelegate>

@property (nonatomic, assign) BOOL hasAddTarget;//是否已经添加了点击回调 避免重复addTarget操作
@property (nonatomic, copy) UITextFieldEditValueChangeBlock editValueBlock;//编辑文本回调
@property (nonatomic, assign) int inputMax;//输入框输入的最大长度
@property (nonatomic, copy) NSString *inputRules;//输入规则限制

@end

@implementation UITextField (TYExtention)

/// 创建UITextField
/// @param placeHolder 占位文字
/// @param textColor 输入字体颜色
/// @param font 输入字体大小
/// @param subView 父视图
+ (UITextField *)textFiledWithPlaceHolder:(NSString *)placeHolder
                                textColor:(UIColor *)textColor
                                     font:(int)font
                               addSubView:(UIView *)subView{
    UITextField *textFiled = [[UITextField alloc] init];
    textFiled.placeholder = placeHolder;
    textFiled.textColor = textColor;
    [subView addSubview:textFiled];
    
    return textFiled;
}

//*****是否已经添加了点击回调 避免重复addTarget操作******//
- (void)setHasAddTarget:(BOOL)hasAddTarget{
    objc_setAssociatedObject(self, @selector(hasAddTarget), @(hasAddTarget), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hasAddTarget{
    NSNumber *value = objc_getAssociatedObject(self, @selector(hasAddTarget));
    return value.boolValue;
}

//*****输入监听******//
- (void)setEditValueBlock:(UITextFieldEditValueChangeBlock)editValueBlock{
    if (self.hasAddTarget == NO) {
        //避免重addTarget
        self.hasAddTarget = YES;
        [self addTarget:self action:@selector(textFiledValueEditChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    objc_setAssociatedObject(self, &UITextFieldEditKey, editValueBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UITextFieldEditValueChangeBlock)editValueBlock{
    return objc_getAssociatedObject(self, &UITextFieldEditKey);
}

//*****输入最大长度******//
- (void)setInputMax:(int)inputMax{
    objc_setAssociatedObject(self, @selector(inputMax), @(inputMax), OBJC_ASSOCIATION_ASSIGN);
}

- (int)inputMax{
    NSNumber *value = objc_getAssociatedObject(self, @selector(inputMax));
    return value.intValue;
}
//*****输入监听  限制输入长度******//
- (void)textFiledValueEditChanged:(UITextField *)textField{
    //在有输入长度限制的情况下 限制输入长度
    if (self.inputMax) {
        if (textField.text.length > self.inputMax) {
            textField.text = [textField.text substringToIndex:self.inputMax];
        }
    }
    if (self.editValueBlock) {
        //如果实现了输入Block回调，将结果回调出去
        self.editValueBlock(textField);
    }
}

//*****输入监听  输入规则的限制******//
- (void)setInputRules:(NSString *)inputRules{
    self.delegate = self;
    objc_setAssociatedObject(self, &UITextFieldInputRulesKey, inputRules, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)inputRules{
    return objc_getAssociatedObject(self, &UITextFieldInputRulesKey);
}

/// 对UITextFiled输入框的输入长度和规则做限制 并回调输入显示的结果
/// @param inputMax 输入框输入的最大长度
/// @param inputRules 输入规则限制
/// @param editValueBlock 输入回调
- (void)setTextFieldInputMax:(int)inputMax inputRules:(NSString *)inputRules editValueBlock:(UITextFieldEditValueChangeBlock)editValueBlock{
    self.inputRules = inputRules;
    self.inputMax = inputMax;
    self.editValueBlock = editValueBlock;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.inputRules isEqualToString:@""]) {
        return YES;
    }
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:self.inputRules] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    RYQLog(@"楷书输入了")
    
    return YES;
}

@end
