//
//  MinimumTreeVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/23.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 最小生成树的算法主要分为两种：普里姆算法和克鲁斯卡尔算法。
 我们把构造连通网的最小代价生成树称为最小生成树。
 */

#import "MinimumTreeVC.h"

#define MaxEdge 20
#define MaxVex 20
#define Infinity 65535

/**
 矩阵
 */
typedef struct {
    int arc[MaxVex][MaxVex];
    int numVertexes, numEdges;
}MGraph;

/**
 对边集数组Edge结构的定义
 */
typedef struct {
    int begin;
    int end;
    int weight;
}Edge;

@interface MinimumTreeVC ()

@end

@implementation MinimumTreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGraph graph;
    //构建图
    CreateMinimumTreeMGraph(&graph);
    //普里姆算法 计算最小生成树
    PrimMiniSpanTree(graph);
    //克鲁斯卡尔算法  计算最小生成树
    KruskalMiniSpanTree(graph);
}

/**
 构建图
 @param graph 空图
 */
void CreateMinimumTreeMGraph(MGraph *graph)
{
    int i, j;
    
    graph->numEdges = 15;//边数
    graph->numVertexes = 9;//顶点数
    
    for (i = 0; i < graph->numVertexes; i++) {//初始化图
        for (j = 0; j < graph->numVertexes; j++) {
            if (i == j) {
                graph->arc[i][j] = 0;
            }else{
                graph->arc[i][j] = graph->arc[j][i] = Infinity;
            }
        }
    }
    
    //边权重的赋值
    graph->arc[0][1]=10;
    graph->arc[0][5]=11;
    graph->arc[1][2]=18;
    graph->arc[1][8]=12;
    graph->arc[1][6]=16;
    graph->arc[2][8]=8;
    graph->arc[2][3]=22;
    graph->arc[3][8]=21;
    graph->arc[3][6]=24;
    graph->arc[3][7]=16;
    graph->arc[3][4]=20;
    graph->arc[4][7]=7;
    graph->arc[4][5]=26;
    graph->arc[5][6]=17;
    graph->arc[6][7]=19;
    
    for (i = 0; i < graph->numVertexes; i++) {
        for (j = i; j < graph->numVertexes; j++) {
            graph->arc[j][i] = graph->arc[i][j];
        }
    }
}

/**
 普里姆算法 计算最小生成树

 @param graph 图
 */
void PrimMiniSpanTree(MGraph graph)
{
    RYQLog(@"普里姆算法 计算最小生成树");
    int min, i, j, k;
    int adjVex[MaxVex];//保存相关顶点下标
    int lowCost[MaxVex];//保存相关顶点间边的权值
    lowCost[0] = 0;//lowCost的值为0，在这里就是此下标的顶点已经加入生成树。初始化第一个权值为0，即v0加入生成树。
    adjVex[0] = 0;//初始化第一个顶点下标为0
    
    for (i = 1; i < graph.numVertexes; i++) {//循环除下标为0外的其他顶点
        lowCost[i] = graph.arc[0][i];//将v0顶点与之有边的权值存入数组
        adjVex[i] = 0;//初始化都为v0的下标
    }
    
    for (i = 1; i < graph.numVertexes; i++) {
        min = Infinity;//初始化最小权值为无穷大
        j = 1; k = 0;
        while (j < graph.numVertexes) {//循环全部顶点
            if (lowCost[j] != 0 && lowCost[j] < min) {//如果权值不为0且权值小于min
                min = lowCost[j];//则让当前权值成为最小值
                k = j;//将当前最小值的下标存入k
            }
            j++;
        }
        RYQLog(@"(%d, %d)  此路径的最小值为%d ", adjVex[k], k, min);//打印当前顶点边中权值最小的边
        lowCost[k] = 0;//将当前顶点的权值设为0，表示此顶点已经完成任务
        for (j = 1; j < graph.numVertexes; j++) {//循环所有顶点
            if (lowCost[j] != 0 && graph.arc[k][j] < lowCost[j]) {
                //如果下标为k顶点各边权值小于此前这些顶点未被加入生成树权值
                lowCost[j] = graph.arc[k][j];//将较小的权值存入lowCost相应位置
                adjVex[j] = k;//将下标为k的顶点存入adjVex
            }
        }
    }
}

/**
 克鲁斯卡尔算法  计算最小生成树

 @param graph 图
 */
void KruskalMiniSpanTree(MGraph graph)
{
    int i, j, n, m;
    int k = 0;
    int parent[MaxVex];//定义一数组用来判断边与边是否形成环路
    
    Edge edges[MaxEdge];//定义边集数组，edge的结构为begin，end，weight均为整型
    //用来构建边集数组并排序
    for (i = 0; i < graph.numVertexes-1; i++) {
        for (j = i + 1; j < graph.numVertexes; j++) {
            if (graph.arc[i][j] < Infinity) {
                edges[k].begin = i;
                edges[k].end = j;
                edges[k].weight = graph.arc[i][j];
                k++;
            }
        }
    }
    //对权值进行排序
    KruskalSort(edges, &graph);
    
    for (i = 0; i < graph.numVertexes; i++) {
        parent[i] = 0;//初始化数组值为0
    }
    RYQLog(@"打印最小生成树");
    for (i = 0; i < graph.numEdges; i++) {//循环每一条边
        n = KruskalFind(parent, edges[i].begin);
        m = KruskalFind(parent, edges[i].end);
        if (n != m) {
            //假如n与m不相等。说明此边没有与现有的生成树形成环路
            parent[n] = m;//将此边的尾顶点放入下标为起点的parent中，表明此顶点已经在生成树集合中
            RYQLog(@"(%d,%d) weight = %d", edges[i].begin, edges[i].end, edges[i].weight);
        }
    }
}

/**
 对权值进行排序
 */
void KruskalSort(Edge edges[], MGraph *graph)
{
    int i , j;
    for (i = 0; i < graph->numEdges; i++) {
        for (j = i+1; j < graph->numEdges; j++) {
            if (edges[i].weight > edges[j].weight) {
                KruskalSwip(edges, i, j);
            }
        }
    }
    RYQLog(@"权排序之后的为");
    for (i = 0; i < graph->numEdges; i++) {
        RYQLog(@"(%d,%d)  weight = %d", edges[i].begin, edges[i].end, edges[i].weight);
    }
}

/**
 交换权值以及头和尾
 */
void KruskalSwip(Edge *edges, int i, int j)
{
    int temp;
    temp = edges[i].begin;
    edges[i].begin = edges[j].begin;
    edges[j].begin = temp;
    temp = edges[i].end;
    edges[i].end = edges[j].end;
    edges[j].end = temp;
    temp = edges[i].weight;
    edges[i].weight = edges[j].weight;
    edges[j].weight = temp;
}

/**
 查找连线顶点的尾部下标
 */
int KruskalFind(int *parent, int find)
{
    while (parent[find] > 0) {
        find = parent[find];
    }
    return find;
}

@end
