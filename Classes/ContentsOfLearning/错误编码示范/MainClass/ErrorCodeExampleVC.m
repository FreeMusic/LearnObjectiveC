//
//  ErrorCodeExampleVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "ErrorCodeExampleVC.h"
#import "BAD_ACCESS_VC.h"

@interface ErrorCodeExampleVC ()

@end

@implementation ErrorCodeExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"BAD_ACCESS" vc:[BAD_ACCESS_VC new]],
                      ];
}


@end
