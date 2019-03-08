//
//  KVO_Model.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "KVC_Model.h"

@interface KVC_Model()

@property (nonatomic, copy) NSString *privacy;//隐私

@end

@implementation KVC_Model

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.name = @"KVC";
        self.age = @"18";
        self.privacy = @"这里是个人隐私";
        
    }
    return self;
}


@end
