//
//  TransmitObject.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/12.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "TransmitObject.h"
#import <objc/runtime.h>

@implementation TransmitObject


/**
 可以看到虽然没有实现eat这个函数，但是我们通过class_addMethod动态添加fooMethod函数，并执行fooMethod这个函数的IMP。从打印结果看，成功实现了。如果resolve方法返回 NO ，运行时就会移到下一步：forwardingTargetForSelector。
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    SEL eatSel = NSSelectorFromString(@"eat");
    SEL playSel = NSSelectorFromString(@"play");
    SEL accourSel = NSSelectorFromString(@"accour");
    if (sel == eatSel) {
        class_addMethod([self class], sel, (IMP)eatMethod, "v@:");
        
        return YES;
    }else if (sel == playSel) {
        class_addMethod([self class], sel, (IMP)playMethod, "v@:");
        
        return YES;
    }
    else if (sel == accourSel) {
        class_addMethod([self class], sel, (IMP)accourMethod, "v@:");
        
        return YES;
    }
    
    return [super resolveClassMethod:sel];
}

void eatMethod (id obj, SEL _cmd) {
    XYLog(@"eatMethod   消息的转发");
}

void playMethod (id obj, SEL _cmd) {
    XYLog(@"playMethod   消息的转发");
}

void accourMethod (id obj, SEL _cmd) {
    XYLog(@"accourMethod   消息的转发");
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    SEL playSel = NSSelectorFromString(@"play");
    if (aSelector == playSel) {
        //返回一个对象  让这个对象接收这个消息
        class_addMethod([self class], aSelector, (IMP)playMethod, "v@:");
    }
    
    return [super forwardingTargetForSelector:aSelector];
}



@end
