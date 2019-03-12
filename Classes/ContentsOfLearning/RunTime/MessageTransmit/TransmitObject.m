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

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    
    
    if (sel == @selector(eat)) {
        class_addMethod([self class], sel, (IMP)eatMethod, "v@:");
        
        return YES;
    }
    
    return [super resolveClassMethod:sel];
}

void eatMethod (id obj, SEL _cmd) {
    RYQLog(@"classMethod");
}

@end
