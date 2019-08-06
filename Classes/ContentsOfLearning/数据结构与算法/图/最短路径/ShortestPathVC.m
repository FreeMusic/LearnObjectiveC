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

typedef int FloydPathArc[MaxVex][MaxVex];
typedef int FloydShortPathTable[MaxVex][MaxVex];

@interface ShortestPathVC ()



@end

@implementation ShortestPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int v0;
    MGraph graph;
    PathArc path;
    ShortPathTable shortPath;//求顶点到其余各点的最短路径
    v0 = 0;
    //构建图
    CreateShortPathMGraph(&graph);
    //迪杰斯特拉算法
    DijkstraShortestPath(graph, v0, &path, &shortPath);
    //弗洛伊德算法
    FloydPathArc Floydpath;
    FloydShortPathTable FloydshortPath;//求顶点到其余各点的最短路径
    FloydShortestPath(graph, &Floydpath, &FloydshortPath);
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
    
    for (i = 0; i < graph->numVertexes; i++) {
        for (j = i; j < graph->numVertexes; j++) {
            graph->arc[j][i] = graph->arc[i][j];
        }
    }
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
    RYQLog(@"迪杰斯特拉算法求最短路径");
    int v,w,k = 0,min;
    int remerK = 0;
    NSString *pathDescribtion = [NSString stringWithFormat:@"最短路径为: v%d", graph.vexs[0]];
    int final[MaxVex];//final[w]=1表示求得定点v0到vw的最短路径
    for (v = 0; v < graph.numVertexes; v++) {
        //初始化数据
        final[v] = 0;//全部顶点初始化为未知最短路径状态
        (*shortPath)[v] = graph.arc[v0][v];//将与v0点有连线的顶点加上权值
        (*path)[v] = -1;//初始化路径数组path为-1
    }
    
    (*shortPath)[v0] = 0;//v0到v0的路径为0
    final[v0] = 1;//v0到v0不需要求路径
    //开始主循环，每次求得v0到某个v顶点的最短路径
    for (v = 1; v < graph.numVertexes; v++) {
        min = Infinity;//当前所知离v0顶点的最近距离
        for (w = 0; w < graph.numVertexes; w++) {//寻找离v0的最近的顶点
            if (!final[w] && (*shortPath)[w] < min) {
                k = w;
                min = (*shortPath)[w];//w顶点离v0顶点更近
            }
        }
        final[k] = 1;//将目前找到的最近的位置点设置为1
        for (w = 0; w < graph.numVertexes; w++) {//修正当前最短路径和距离
            //如果经过v顶点的路径比现在这条路的长度短的话
            if (!final[w] && (min+graph.arc[k][w] < (*shortPath)[w])) {
                //说明找到了更短的路径 修改(*shortPath)[w]和path[w]
                (*shortPath)[w] = min + graph.arc[k][w];//修改当前路径的长度
                (*path)[w] = k;
                if (remerK != k) {
                    remerK = k;
                    pathDescribtion = [pathDescribtion stringByAppendingString:[NSString stringWithFormat:@" -> v%d", remerK]];
                }
            }
        }
    }
    pathDescribtion = [pathDescribtion stringByAppendingString:[NSString stringWithFormat:@" -> v%d", graph.numVertexes-1]];
    RYQLog(@"%@", pathDescribtion);
    
    for (int i = 1; i < graph.numVertexes; ++i) {
        RYQLog(@"v%d到v%d的最短路径为: %d", graph.vexs[0] , graph.vexs[i], (*shortPath)[i]);
    }
}

/**
 Floyd算法，求网图graph中各顶点到其余顶点w的最短路径path[v][w]以及带权长度shortPath[v][w]

 @param graph 网图
 @param path 最短路径
 @param shortPath 带权长度
 */
void FloydShortestPath(MGraph graph, FloydPathArc *path, FloydShortPathTable *shortPath)
{
    int v, w, k;
    for (v = 0; v < graph.numVertexes; v++) {//初始化path和shortPath
        for (w = 0; w < graph.numVertexes; w++) {
            (*shortPath)[v][w] = graph.arc[v][w];//shortPath[v][w]值即为对应点间的权值
            (*path)[v][w] = w;//初始化path
        }
    }
    
    for (k = 0; k < graph.numVertexes; k++) {
        for (v = 0; v < graph.numVertexes; v++) {
            for (w = 0; w < graph.numVertexes; w++) {
                //如果经过下标为k顶点路径比原来两点间的路径更短
                (*shortPath)[v][w] = (*shortPath)[v][k] + (*shortPath)[k][w];//将当前两个顶点间权值设为更小的一个
                (*shortPath)[v][w] = (*path)[v][k];//路径设置为径路下标为k的顶点
            }
        }
    }
    
    for (v= 0; v < graph.numVertexes; v++) {
        for (w = k+1; w < graph.numVertexes; w++) {
            RYQLog(@"v%d-v%d  weight:%d", v, w, (*shortPath)[v][w]);
            k = (*path)[v][w];//获得第一个路径顶点下标
            RYQLog(@"path : %d", v);//打印路径顶点
        }
    }
}

@end
