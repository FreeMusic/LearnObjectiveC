//
//  MainGraphVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/1.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainGraphVC.h"

@interface MainGraphVC ()

@end

@implementation MainGraphVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"图的定义" vcName:@"DefineGraphVC"],
                      [ObjectiveModel initTitle:@"图邻接矩阵创建" vcName:@"AdjacentMatrixVC"],
                      [ObjectiveModel initTitle:@"邻接表" vcName:@"AdjacencyListVC"],
                      ];
}


@end
