//
//  XYMessagePreventCrashObject.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/8/13.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "XYMessagePreventCrashObject.h"
#import "XYMessageTool.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation XYMessagePreventCrashObject

#pragma mark ------消息转发的第一步-------
/// 尝试为该类添加类方法
/// @param sel 添加的方法
/// YES表示能够接受该消息；NO表示不能接收消息。
+ (BOOL)resolveClassMethod:(SEL)sel {
    RYQLog(@"<%@>类没有实现类方法: %@,请尽快处理!", NSStringFromClass([self class]), NSStringFromSelector(sel));
    [XYMessageTool addClassMethodWithSel:sel withClass:[self class] impMethodSel:@selector(addClassMethod)];
    BOOL canAdd = [super resolveClassMethod:sel];
    return canAdd;
}
/// 尝试为该类添加实例方法
/// @param sel 添加的方法
/// YES表示能够接受该消息；NO表示不能接收消息。
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    RYQLog(@"<%@>类没有实现实例方法: %@,请尽快处理!", NSStringFromClass([self class]), NSStringFromSelector(sel));
    [XYMessageTool addInstanceMethodWithSel:sel withClass:[self class] impMethodSel:@selector(addInstaceMethod)];
    BOOL canAdd = [super resolveInstanceMethod:sel];
    return canAdd;
}

- (void)addInstaceMethod {
//    RYQLog(@"动态添加实例方法");
}

+ (void)addClassMethod {
//    RYQLog(@"动态添加类方法");
}

@end
