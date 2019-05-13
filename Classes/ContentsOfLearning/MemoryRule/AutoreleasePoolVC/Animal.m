
//
//  Animal.m
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/5/12.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (void)dealloc{
    RYQLog(@"第%d个Animal--Class 销毁了", self.order);
}

@end
