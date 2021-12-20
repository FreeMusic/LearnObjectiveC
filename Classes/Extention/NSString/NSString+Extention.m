//
//  NSString+Extention.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/12/20.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "NSString+Extention.h"

@implementation NSString (Extention)

- (BOOL)isEmpty {
    if (![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    return self.length;
}

@end
