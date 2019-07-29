//
//  ShortestPathVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/25.
//  Copyright © 2019 橘子. All rights reserved.
//  对于网图来说，最短路径是指两个顶点之间经过的边上权值之和最少的路径，并且我们称路径上的第一个顶点是源点，最后一个顶点是终点。  主要分为：迪杰斯特拉算法（Dijkstra）和弗洛伊德算法（Floyd）两种

#import "ShortestPathVC.h"
#define MaxEdge 20
#define MaxVex 20
#define Infinity 65535

typedef struct {
    int vexs[MaxVex];
    int arc[MaxVex][MaxVex];
    int numVertexes, numEdges;
}MGraph;

typedef int PathArc[MaxVex];//用于存储最短路径下标的数组
typedef int ShortPathTable[MaxVex];//用于存储到各点最短路径的权值和

@interface ShortestPathVC ()



@end

@implementation ShortestPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int i, j, v0;
    MGraph graph;
    PathArc path;
    ShortPathTable shortPath;//求顶点到其余各点的最短路径
    v0 = 0;
    //构建图
    CreateShortPathMGraph(&graph);
    //迪杰斯特拉算法
    DijkstraShortestPath(graph, v0, &path, &shortPath);
}

/**
 构建图

 @param graph 图
 */
void CreateShortPathMGraph(MGraph *graph)
{
    int i, j;
    graph->numEdges = 16;//边数
    graph->numVertexes = 9;//顶点数
    
    for (i = 0; i < graph->numVertexes; i++) {//初始化图
        graph->vexs[i] = i;
    }
    
    for (i = 0; i < graph->numVertexes; i++) {//初始化图
        for (j = 0; j < graph->numVertexes; j++) {
            if (i == j) {
                graph->arc[i][j] = 0;
            }else{
                graph->arc[i][j] = graph->arc[j][i] = Infinity;
            }
        }
    }
    //两点之间路径长度的赋值
    graph->arc[0][1] = 1;
    graph->arc[0][2] = 5;
    graph->arc[1][2] = 3;
    graph->arc[1][3] = 7;
    graph->arc[1][4] = 5;
    
    graph->arc[2][4] = 1;
    graph->arc[2][5] = 7;
    graph->arc[3][4] = 2;
    graph->arc[3][6] = 3;
    graph->arc[4][5] = 3;
    
    graph->arc[4][6] = 6;
    graph->arc[4][7] = 9;
    graph->arc[5][7] = 5;
    graph->arc[6][7] = 2;
    graph->arc[6][8] = 7;
    
    graph->arc[7][8] = 4;
}

/**
 Dijkstra算法  求有向网graph的v0顶点到其余顶点v的最短路径path[v]及带权长度shortPath[v]
 path[v]的值为前驱顶点下标，shortPath[v]表示v0到v的最短路径长度和

 @param graph 有向网graph
 @param v0 v0顶点
 @param path 最短路径path[v]
 @param shortPath 带权长度shortPath[v]
 */
void DijkstraShortestPath(MGraph graph, int v0, PathArc *path, ShortPathTable *shortPath)
{
    
}

@end
