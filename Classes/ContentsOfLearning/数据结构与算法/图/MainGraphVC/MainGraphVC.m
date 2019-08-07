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
                      [ObjectiveModel initTitle:@"十字链表" vcName:@"CurbTableVC"],
                      [ObjectiveModel initTitle:@"邻接多重表" vcName:@"ADJacencyMultiplelistVC"],
                      [ObjectiveModel initTitle:@"边集数组" vcName:@"EdgeListVC"],
                      [ObjectiveModel initTitle:@"深度优先遍历和广度优先遍历(邻接矩阵)" vcName:@"DepthFirstSeachVC"],
                      [ObjectiveModel initTitle:@"深度广度优先遍历(邻接表)" vcName:@"BreadthFirstSearchVC"],
                      [ObjectiveModel initTitle:@"最小生成树" vcName:@"MinimumTreeVC"],
                      [ObjectiveModel initTitle:@"最短路径" vcName:@"ShortestPathVC"],
                      [ObjectiveModel initTitle:@"拓扑排序" vcName:@"TopologicalSortingVC"],
                      ];
}


@end
