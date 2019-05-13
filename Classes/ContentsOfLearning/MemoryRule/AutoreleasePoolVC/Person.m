//
//  Person.m
//  AutoReleasePoolTest
//
//  Created by Apple on 2019/5/13.
//  Copyright © 2019 tutuge. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)dealloc
{
    NSLog(@"第%d个Person类已经销毁了", self.page);
}

@end
