//
//  KVO_AimModel.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/8.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "KVO_AimModel.h"
#import <objc/runtime.h>

@implementation KVO_AimModel

/**
 默认 yes, 默认自动观察所有属性
 */
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key{
    return YES;
}


+ (BOOL)automaticallyNotifiesObserversOfAge {
    return YES;
}

@end



//@implementation NSObject (RYQKVO)
//
//- (void)ryq_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
//    
//    //新建一个类
//    NSString *className = [@"RYQKVO" stringByAppendingString:NSStringFromClass([self class])];
//    Class newClass = objc_allocateClassPair([self class], className.UTF8String, 0);
//    RYQLog(@"%@", newClass);
//    //注册类
//    objc_registerClassPair(newClass);
//    //修改 调用者类型
//    object_setClass(self, newClass);
//    
//    //给子类添加self方法 (子类里面没有set方法的)
//    //Objective-C方法：方法编号SEL，方法实现IMP
//    class_addMethod(newClass, @selector(ryqsetName:), ryqsetName, "");
//}
//
///*
// 隐藏的参数:
// self  方法的调用者
// _cmd  方法的编号
// */
//void ryqsetName(id self,SEL _cmd, NSString *newName) {
//    RYQLog(@"自定义的实现%@",newName);
//}
//
//@end
