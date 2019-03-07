//
//  RunTimeMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "RunTimeMainVC.h"
#import "KVC_VC.h"
#import "KVO_VC.h"

@interface RunTimeMainVC ()

@end

@implementation RunTimeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"KVC" vc:[KVC_VC new]],
                      [ObjectiveModel initTitle:@"KVO" vc:[KVO_VC new]],
                      ];
}

- (void)dealloc {
    
    RYQLog(@"dealloc");
    
}


@end
