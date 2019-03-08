//
//  CopyTargetVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/8.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "CopyTargetVC.h"

@interface CopyTargetVC ()

@end

@implementation CopyTargetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    RYQLog(@"视图已经消失了");
}

- (void)dealloc {
    RYQLog(@"CopyTargetVC 已经被销毁");
}


@end
