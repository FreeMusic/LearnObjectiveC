//
//  CriticalPathVC.m
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/8/12.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 关键路径：在一个表示工程的带权有向图中，用顶点表示事件，用有向边表示活动，用边上的权值表示活动的持续时间，这种有向图的边表示活动的网，我们称之为AOE网(Activity On Edge Network)
 我们把AOE网中没有入边的顶点称为始点或源点，没有出边的顶点称为终点或汇点
 路径上各个活动所持续的时间之合称为路径长度，从原点到汇点具有最大长度的路径叫做关键路径，在关键路径上的活动叫做关键活动
 */
#import "CriticalPathVC.h"

#define MaxEdge 30
#define MaxVex 30
#define Infinity 65535

int *etv, *ltv;//事件最早发生时间和最迟发生时间数组，全局变量
int *stack2;//o用于存储拓扑排序列的栈
int top2;//用于stack2的指针

/**
 邻接矩阵结构
 */
typedef struct {
    int vexs[MaxVex];
    int arc[MaxVex][MaxVex];
    int numVertexs, numEdges;
}MGraph;
/**
 邻接表结构
 */
typedef struct EdgeNode {//边表结点
    int adjVex;//邻接点域，存储该顶点对应的下标
    int weight;//用于存储权值，对于非网图可以不需要
    struct EdgeNode *next;//链域，指向下一个邻接点
}EdgeNode;
/**
 顶点表结点
 */
typedef struct VertexNode {
    int inCome;//顶点入度
    int data;//顶点域，存储顶点信息
    struct EdgeNode *firstEdge;//边表头指针
}VertexNode, ADJlist[MaxVex];

/**
 邻接表
 */
typedef struct {
    ADJlist list;
    int numVertexs, numEdges;//图中当前顶点数和边数
}graphADJlist, *GraphADJlist;

@interface CriticalPathVC ()



@end

@implementation CriticalPathVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGraph graph;
    //构建图
    CreateCriticalPathMGraph(&graph);
}

/**
 构建图
 */
void CreateCriticalPathMGraph(MGraph *graph)
{
    int i, j;
    graph->numVertexs = 10;//顶点数
    graph->numEdges = 13;//边数
    
    for (i = 0; i < graph->numVertexs; i++) {
        graph->vexs[i] = i;
    }
    
    for (i = 0; i < graph->numVertexs; i++) {//初始化图
        for (j = 0; j < graph->numVertexs; j++) {
            if (i == j) {
                graph->arc[i][j] = 0;
            }else{
                graph->arc[i][j] = Infinity;
            }
        }
    }
    
    graph->arc[0][1] = 3;
    graph->arc[0][2] = 4;
    graph->arc[1][3] = 5;
    graph->arc[1][4] = 6;
    graph->arc[2][3] = 8;
    graph->arc[2][5] = 7;
    graph->arc[3][4] = 3;
    graph->arc[4][6] = 9;
    graph->arc[4][7] = 4;
    graph->arc[5][7] = 6;
    graph->arc[6][9] = 2;
    graph->arc[7][8] = 5;
    graph->arc[8][9] = 3;
}

@end
