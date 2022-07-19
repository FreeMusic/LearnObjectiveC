//
//  UIButton+Extenion.m
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/4/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "UIButton+Extenion.h"
#import <objc/runtime.h>

//runtime用键取值 此处定义一个键  键的类型随意 int 什么都可以  但是char类型占用内存最小
static char buttonActionKey;

static char *const kEventIntervalKey = "XY_KEventIntervalKey";//时间间隔
static char *const kEventInvalidKey = "XY_KEventInvalidKey";//是否失效

@interface UIButton ()

@property (nonatomic, assign) BOOL xy_eventInvalid;///

@end

@implementation UIButton (Extenion)

+ (void)load {
//    Method clickMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
//    Method xy_clickMethod = class_getInstanceMethod(self, @selector(xy_sendAction:to:forEvent:));
//    method_exchangeImplementations(clickMethod, xy_clickMethod);
}

//按钮背景色的setter 和 getter方法实现
- (void)setColor:(SXYButtonBackColor)color{
    objc_setAssociatedObject(self, @selector(color), @(color), OBJC_ASSOCIATION_ASSIGN);
    if (color == ButtonWhiteColor){
        self.userInteractionEnabled = YES;
        [self setTitleColor:DarkNavigationColor forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
    }else if (color == ButtonClearColor){
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor clearColor]];
    }else if (color == ButtonYellowColor){
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor yellowColor]];
    }else if (color == ButtonNormalColorWithLine){
        [self setTitleColor:DarkNavigationColor forState:0];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderWidth = 1;
        self.layer.borderColor = DarkNavigationColor.CGColor;
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else if (color == ButtonBlueColor){
        //        [self setBackgroundColor:RGB(108, 234, 206)];
        self.userInteractionEnabled = YES;
    }else if (color == ButtonNormalColor){
//        self.userInteractionEnabled = YES;
//        [self setBackgroundImage:[Factory initImageWithFrame:CGRectMake(0, 0, kScreenWidth-80*m6Scale, 90*m6Scale)] forState:UIControlStateNormal];
//        self.layer.borderWidth = 0;
//        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if (color == ButtonDarkColor){
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:UIColorFromRGB(0xf44351)];
    }else if (color == ButtonTintColor){
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:UIColorFromRGB(0xff5d34)];
    }else if (color == ButtonWhiteColorWithLine){
        [self setTitleColor:DarkNavigationColor forState:0];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderWidth = 1;
        self.layer.borderColor = DarkNavigationColor.CGColor;
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else if (color == ButtonBlackTitleNormalBackColor){
        [self setTitleColor:BLACK_COLOR forState:0];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else if (color == ButtonGrayColorWithLine){
        [self setTitleColor:UIColorFromRGB(0x999999) forState:0];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromRGB(0x999999).CGColor;
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

- (SXYButtonBackColor)color{
    NSNumber *value = objc_getAssociatedObject(self, @selector(color));
    return value.intValue;
}

/**
 *  适用于 有背景颜色 有圆角 的按钮 点击事件可以在block回调中处理
 */
+ (UIButton *)ButtonWithTitle:(NSString *)title ButtonBackColor:(SXYButtonBackColor)buttonBackColor CornerRadius:(CGFloat)radius addSubView:(UIView *)subView buttonActionBlock:(ButtonActionBlock)buttonActionBlock{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.cornerRadius = radius*m6Scale;
    button.layer.masksToBounds = YES;
    button.color = buttonBackColor;
    //取消点击按钮时候的闪烁
    button.adjustsImageWhenHighlighted = NO;
    if (buttonActionBlock) {
        [button addTarget:button action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //最关键的 步骤  block 既可以作为参数 又可以 作为方法  此处将block作为参数  动态绑定到 button上
        objc_setAssociatedObject(button, &buttonActionKey, buttonActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    [subView addSubview:button];
    
    return button;
}
/**
 按钮的点击事件
 
 @param button 按钮
 */
- (void)buttonAction:(UIButton *)button{
    //取出绑定在button上的block
    ButtonActionBlock block = objc_getAssociatedObject(button, &buttonActionKey);
    if (block) {
        block(button);
    }
}

- (void)xy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (!self.xy_eventInvalid) {
        self.xy_eventInvalid = YES;
        [self xy_sendAction:action to:target forEvent:event];
        [self performSelector:@selector(setXy_eventInvalid:) withObject:@(NO) afterDelay:self.xy_eventInterval];
    }
}

- (NSTimeInterval)xy_eventInterval {
    return [objc_getAssociatedObject(self, kEventIntervalKey) doubleValue];
}

- (void)setXy_eventInterval:(NSTimeInterval)xy_eventInterval {
    objc_setAssociatedObject(self, kEventIntervalKey, @(xy_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)xy_eventInvalid {
    return [objc_getAssociatedObject(self, kEventInvalidKey) boolValue];
}

- (void)setXy_eventInvalid:(BOOL)xy_eventInvalid {
    objc_setAssociatedObject(self, kEventInvalidKey, @(xy_eventInvalid), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
