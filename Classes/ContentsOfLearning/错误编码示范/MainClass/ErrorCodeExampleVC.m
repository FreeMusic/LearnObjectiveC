//
//  ErrorCodeExampleVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "ErrorCodeExampleVC.h"

@interface ErrorCodeExampleVC ()

@end

@implementation ErrorCodeExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string = @{@"key": @"value"};
    RYQLog(@"%d", [string isEmptyString])
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"BAD_ACCESS" vcName:@"BAD_ACCESS_VC"],
                      ];
}

@end
