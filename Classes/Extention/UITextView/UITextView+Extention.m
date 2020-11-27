//
//  UITextView+Extention.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/19.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "UITextView+Extention.h"

@implementation UITextView (Extention)

+ (UITextView *)initWithPlaceHolder:(NSString *)placeHolder textColor:(UIColor *)textColor font:(int)font inputMax:(int)inputMax inputType:(NSString *)inputType addSubView:(UIView *)addSubView {
    UITextView *textView = [[UITextView alloc] init];
    textView.textColor = textColor;
    textView.font = [UIFont systemFontOfSize:font];
    [addSubView addSubview:textView];
    
    
    return textView;
}

@end
