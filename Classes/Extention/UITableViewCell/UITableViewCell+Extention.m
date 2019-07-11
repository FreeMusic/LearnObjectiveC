//
//  UITableViewCell+Extention.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "UITableViewCell+Extention.h"
#import <objc/runtime.h>

@implementation UITableViewCell (Extention)

- (void)setCellHeight:(CGFloat)cellHeight{
    objc_setAssociatedObject(self, @selector(cellHeight), @(cellHeight), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)cellHeight{
    NSNumber *value = objc_getAssociatedObject(self, @selector(cellHeight));
    return value.doubleValue;
}

@end
