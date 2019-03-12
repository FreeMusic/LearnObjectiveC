//
//  MessageTransmitVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/12.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MessageTransmitVC.h"
#import "TransmitObject.h"
//#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/**
 Runtime消息传递一个对象的方法  [obj test]，编译器转成消息发送objc_msgSend(obj, test)，Runtime时执行的流程是这样的：
 1.首先，通过obj的isa指针找到它的class;
 2.在class的method list找test;
 3.如果class中没到test，继续往它的superclass中找;
 4.一旦找到test这个函数，就去执行它的实现IMP
 当然了，由于效率的问题，每个消息都遍历一次objc_method_list并不合理。所以需要把经常被调用的函数缓存下来，去提高函数查询的效率。这也就是objc_class中另一个重要成员objc_cache做的事情 - 再找到test之后，把test的method_name作为key，method_imp作为value给存起来。当再次收到test消息的时候，可以直接在cache里找到，避免去遍历objc_method_list。从前面的源代码可以看到objc_cache是存在objc_class结构体中的。
 */

@interface MessageTransmitVC ()

@end

@implementation MessageTransmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TransmitObject *obj = [[TransmitObject alloc] init];

    //动态添加方法  初始消息转发
    SEL eatSel = NSSelectorFromString(@"eat");
    ((void (*)(id, SEL))[obj methodForSelector:eatSel])(obj, eatSel);
    //动态将MessageTransmitVC的方法转移给TransmitObject实现  二级消息转发
    SEL playSel = NSSelectorFromString(@"play");
    ((void (*)(id, SEL))[self methodForSelector:playSel])(self, playSel);
    //完整的消息转发
    [self completeMessageForwarding];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //返回YES  继续下一步转发
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    SEL playSel = NSSelectorFromString(@"play");
    SEL sel = NSSelectorFromString(@"accour");
    if (aSelector == playSel) {
        //返回一个对象  让这个对象接收这个消息
        return [TransmitObject new];
    }else if (aSelector == sel) {
        //返回nil  进行下一步转发
        return nil;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}
/**
 完整的消息转发
 如果在上一步还不能处理未知消息，则唯一能做的就是启用完整的消息转发机制了。首先它会发送-methodSignatureForSelector:消息获得函数的参数和返回值类型。如果-methodSignatureForSelector:返回nil，Runtime则会发出-doesNotRecognizeSelector:消息，程序这时也就挂掉了。如果返回了一个函数签名，Runtime就会创建一个NSInvocation对象并发送-forwardInvocation:消息给目标对象。
 */
- (void)completeMessageForwarding {
    
    SEL sel = NSSelectorFromString(@"accour");
    ((void (*)(id, SEL))[self methodForSelector:sel])(self, sel);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if ([NSStringFromSelector(aSelector) isEqualToString:@"accour"]) {
        //签名进入 forward Invocation
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    
    TransmitObject *obj = [[TransmitObject alloc] init];
    if ([obj respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:obj];
    }else{
        RYQLog(@"没有找到该方法");
        return;
    }
}

@end
