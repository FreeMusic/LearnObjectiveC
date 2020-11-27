//
//  UITextView+Extention.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/19.
//  Copyright © 2020 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Extention)

+ (UITextView *)initWithPlaceHolder:(NSString *)placeHolder textColor:(UIColor *)textColor font:(int)font inputMax:(int)inputMax inputType:(NSString *)inputType addSubView:(UIView *)addSubView;

@end

NS_ASSUME_NONNULL_END
