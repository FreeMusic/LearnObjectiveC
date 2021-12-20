//
//  NSObject+Extention.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/12/20.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "NSObject+Extention.h"

@implementation NSObject (Extention)

- (BOOL)isEmptyString {
    if (![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    NSString *value = (NSString *)self;
    return value.length;
}

@end
