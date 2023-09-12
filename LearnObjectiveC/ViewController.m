//
//  ViewController.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "ViewController.h"
#import "ErrorCodeExampleVC.h"
#import "RunLoopMainVC.h"
#import "RunTimeMainVC.h"
#import "MemoryMainVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Learn Objective-C";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.Messages = @[
                    [ObjectiveModel initTitle:@"错误编码示范" vcName:@"ErrorCodeExampleVC"],
                    [ObjectiveModel initTitle:@"运行时" vcName:@"RunTimeMainVC"],
                    [ObjectiveModel initTitle:@"RunLoop" vcName:@"RunLoopMainVC"],
                    [ObjectiveModel initTitle:@"内存管理" vcName:@"MemoryMainVC"],
                    [ObjectiveModel initTitle:@"设计模式" vcName:@"DesignMainVC"],
                    [ObjectiveModel initTitle:@"功能优化" vcName:@"FunctionVC"],
                    [ObjectiveModel initTitle:@"数据结构与算法" vcName:@"MainStructureVC"],
                    [ObjectiveModel initTitle:@"解读NSObject" vcName:@"InterpretationNSObjectVC"],
                    [ObjectiveModel initTitle:@"第三方SDK使用体验" vcName:@"ThirdSDKVC"],
                    [ObjectiveModel initTitle:@"UIKit相关属性" vcName:@"UIKitPlayVC"],
                    [ObjectiveModel initTitle:@"Fundation相关属性" vcName:@"FundationPlayVC"],
    ];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    XYLog(@"ViewController 执行了viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    XYLog(@"ViewController 执行了viewDidDisappear");
}


@end
