//
//  MemoryMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/8.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MemoryMainVC.h"
#import "CopyTargetVC.h"
 
@interface MemoryMainVC ()

@end

@implementation MemoryMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"控制器不执行dealloc" vc:[CopyTargetVC new]],
                      ];
}


@end
