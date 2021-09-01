//
//  XYMessageObject.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/8/11.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "XYMessageObject.h"
#import "XYMessageTool.h"
#import "XYFuctionObject.h"
#import "XYLastFunctionObject.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation XYMessageObject

#pragma mark ------消息转发的第一步-------
/// 尝试为该类添加类方法
/// @param sel 添加的方法
/// YES表示能够接受该消息；NO表示不能接收消息。
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    RYQLog(@"消息转发的第一步：<%@>类没有实现类方法: %@,请尽快处理!", NSStringFromClass([self class]), NSStringFromSelector(sel));
////    [XYMessageTool addClassMethodWithSel:sel withClass:[self class] impMethodSel:@selector(addClassMethod)];
//    BOOL canAdd = [super resolveClassMethod:sel];
//    NSString *alert = (canAdd) ? [NSString stringWithFormat:@"能够接受该类方法：%@的消息", NSStringFromSelector(sel)] :
//    [NSString stringWithFormat:@"不能接受%@的消息，进入消息转发的第二阶段", NSStringFromSelector(sel)];
//    RYQLog(@"%@", alert);
//    return canAdd;
//}
///// 尝试为该类添加实例方法
///// @param sel 添加的方法
///// YES表示能够接受该消息；NO表示不能接收消息。
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    RYQLog(@"消息转发的第一步：<%@>类没有实现实例方法: %@,请尽快处理!", NSStringFromClass([self class]), NSStringFromSelector(sel));
////    [XYMessageTool addInstanceMethodWithSel:sel withClass:[self class] impMethodSel:@selector(addInstaceMethod)];
//    BOOL canAdd = [super resolveInstanceMethod:sel];
//    NSString *alert = (canAdd) ? [NSString stringWithFormat:@"能够接受该类方法：%@的消息", NSStringFromSelector(sel)] :
//    [NSString stringWithFormat:@"不能接受%@的消息，进入消息转发的第二阶段", NSStringFromSelector(sel)];
//    RYQLog(@"%@", alert);
//    return canAdd;
//}

#pragma mark ------消息转发第二阶段-------
/// 将方法转发给其他的类实现
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *methodName = NSStringFromSelector(aSelector);
    if ([methodName isEqualToString:@"playObject"]) {
        return [[XYFuctionObject alloc] init];
    }else{
        return [NSClassFromString(@"XYXXX") new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark -----消息转发的第三阶段-------
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signAture = [super methodSignatureForSelector:aSelector];
    RYQLog(@"%@", signAture);
    ///如果消息转发的对象是不存在的
    if (signAture == nil) {
        NSMethodSignature *newSign = [NSMethodSignature signatureWithObjCTypes:"v@:"];
        RYQLog(@"%@", newSign);
        return newSign;
    }
    
    return signAture;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    //创建备用对象
    XYLastFunctionObject *baseObject = [[XYLastFunctionObject alloc] init];
    SEL sel = anInvocation.selector;
    //判断备用对象是否可以响应传递进来等待相应的SEL
    if ([baseObject respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:baseObject];
    }else{
        //如果备用对象不响应 则抛出异常。
        [self doesNotRecognizeSelector:sel];
    }
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    RYQLog(@"确实没有实现方法：【%@】", NSStringFromSelector(aSelector));
}

- (void)addInstaceMethod {
//    RYQLog(@"动态添加实例方法");
}

+ (void)addClassMethod {
//    RYQLog(@"动态添加类方法");
}

@end
