//
//  FunctionVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/13.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "FunctionVC.h"

@interface FunctionVC ()

@end

@implementation FunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"App埋点测试" vcName:@"BuriesPointTestVC"],
                      [ObjectiveModel initTitle:@"照片信息" vcName:@"ImageMessageVC"],
                      [ObjectiveModel initTitle:@"一些约束问题" vcName:@"FigureOutLayoutVC"],
                      [ObjectiveModel initTitle:@"GCD" vcName:@"GCDVC"],
                      ];
}


@end
