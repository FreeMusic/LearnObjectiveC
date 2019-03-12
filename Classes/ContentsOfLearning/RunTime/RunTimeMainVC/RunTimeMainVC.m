//
//  RunTimeMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "RunTimeMainVC.h"

@interface RunTimeMainVC ()

@end

@implementation RunTimeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"KVC" vcName:@"KVC_VC"],
                      [ObjectiveModel initTitle:@"KVO" vcName:@"KVO_VC"],
                      [ObjectiveModel initTitle:@"消息转发" vcName:@"MessageTransmitVC"],
                      [ObjectiveModel initTitle:@"防止数组越界" vcName:@"ArrayBoundsVC"],
                      ];
}

- (void)dealloc {
    
    RYQLog(@"dealloc");
    
}


@end
