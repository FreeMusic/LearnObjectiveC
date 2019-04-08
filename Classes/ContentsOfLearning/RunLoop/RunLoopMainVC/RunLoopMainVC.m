//
//  RunLoopMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "RunLoopMainVC.h"

@interface RunLoopMainVC ()

@end

@implementation RunLoopMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = mainCLaunge(3);
    RYQLog(@"%d", a);
}

int mainCLaunge(int agr)
{
    return 4;
}

@end
