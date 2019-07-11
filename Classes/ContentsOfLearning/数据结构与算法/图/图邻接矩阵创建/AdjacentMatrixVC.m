//
//  AdjacentMatrixVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/9.
//  Copyright © 2019 橘子. All rights reserved.
//  图的邻接矩阵存储方式是用两个数组来表示

#import "AdjacentMatrixVC.h"

#define MaxVex 100 //自定义最大顶点数
#define INFINITE 9 //自定义无穷大
#define isLetter(a)  ((((a)>='a')&&((a)<='z')) || (((a)>='A')&&((a)<='Z')))
#define LENGTH(a) (sizeof(a)/sizeof(a[0]))

typedef char VertexType;//顶点类型 由用户自定义
typedef int EdgeType;//边上权值类型由用户定义

typedef struct {
    VertexType vexs[MaxVex];//顶点表
    EdgeType edges[MaxVex][MaxVex];//邻接矩阵 可看作边表
    int numNodes, numEdges;//图中当前的顶点数和边数
}YQGraph;

@interface AdjacentMatrixVC ()

@end

@implementation AdjacentMatrixVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YQGraph graph;
    
    //创建无向网图的邻接矩阵表示
//    CreateUnDirectedYQGraph(&graph, 4, 5);
    //创建有向网图的邻接矩阵表示
    CreateDirectedYQGraph(&graph, 4, 5);
    visitGraph(graph);
}

/**
创建无向网图的邻接矩阵表示
 
 @param graph 无向网图
 */
void CreateUnDirectedYQGraph(YQGraph *graph, int numNodes, int numEdges)
{
    int i, j, weight;
    graph->numNodes = numNodes;
    graph->numEdges = numEdges;
    //读入顶点信息 建立顶点表
    for (i = 0; i < graph->numEdges; i++){
        graph->vexs[i] = i;
    }
    
    for (i = 0; i < graph->numNodes; i++){
        weight = i+1;//权值
        for (j = 0; j < graph->numNodes; j++){
            if (i == j) {
                graph->edges[i][j] = INFINITE;//对角线值取最大值
            }else{
                graph->edges[i][j] = weight;
                graph->edges[j][i] = weight;
            }
        }
    }
}
/**
 创建有向网图的邻接矩阵表示
 
 @param graph 有向网图
 */
void CreateDirectedYQGraph(YQGraph *graph, int numNodes, int numEdges){
    int i, j;
    graph->numNodes = numNodes;
    graph->numEdges = numEdges;
    //读入顶点信息 建立顶点表
    for (i = 0; i < graph->numEdges; i++){
        graph->vexs[i] = i;
    }
    for (i = 0; i < graph->numNodes; i++){
        for (j = 0; j < graph->numNodes; j++){
            if (i == j) {
                graph->edges[i][j] = 0;
            }else{
                if (i != 1) {
                    graph->edges[i][j] = 1;
                }
            }
        }
    }
}

/**
 遍历打印矩阵队形图

 @param graph 图
 */
void visitGraph(YQGraph graph)
{
    int i , j;
    for (i = 0; i < graph.numNodes; i++) {
        NSString *content = @"";
        for (j = 0; j < graph.numNodes; j++) {
            content = [NSString stringWithFormat:@"%@%d    ", content, graph.edges[i][j]];
        }
        RYQLog(@"%@\n", content);
    }
}

@end
