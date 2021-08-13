//
//  XYMessageTool.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/8/11.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "XYMessageTool.h"
#import <objc/runtime.h>

@implementation XYMessageTool

/// 获取本类的元类
+(Class)getMetaClassWithChildClass:(Class)childClass{
    //转换字符串类别
    const  char * classChar = [NSStringFromClass(childClass) UTF8String];
    //需要char的字符串 获取元类
    return objc_getMetaClass(classChar);
}

+ (void)addInstanceMethodWithSel:(SEL)sel withClass:(Class)selClass impMethodSel:(SEL)impMethodSel {
    Method method = class_getInstanceMethod(selClass, impMethodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(selClass, sel, methodIMP, types);
}

+ (void)addClassMethodWithSel:(SEL)sel withClass:(Class)selClass impMethodSel:(SEL)impMethodSel {
    Method method = class_getClassMethod([self getMetaClassWithChildClass:selClass], impMethodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod([self getMetaClassWithChildClass:selClass], sel, methodIMP, types);
}

@end
