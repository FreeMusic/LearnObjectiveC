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
    GraphADJlist list;
    //构建图
    CreateCriticalPathMGraph(&graph);
    //利用邻接矩阵构建邻接表
    CreateCriticalPathALGraph(graph, &list);
    //求关键路径，graphlist为有向图，输出graphlist的各项相关活动
    CriticalPath(list);
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

/**
 利用邻接矩阵构建邻接表
 */
void CreateCriticalPathALGraph(MGraph graph, GraphADJlist *graphlist)
{
    int i, j;
    EdgeNode *edge;
    
    *graphlist = (GraphADJlist)malloc(sizeof(graphADJlist));
    
    (*graphlist)->numVertexs = graph.numVertexs;
    (*graphlist)->numEdges = graph.numEdges;
    
    for (i = 0; i < graph.numVertexs; i++) {
        //读入顶点信息，建立顶点表
        (*graphlist)->list[i].inCome = 0;
        (*graphlist)->list[i].data = graph.vexs[i];
        (*graphlist)->list[i].firstEdge = NULL;//将边表置为空
    }
    
    for (i = 0; i < graph.numVertexs; i++) {//建立边表
        for (j = 0; j < graph.numVertexs; j++) {
            if (graph.arc[i][j] != 0 && graph.arc[i][j] < Infinity) {
                RYQLog(@"j = %d", j);
                edge = (EdgeNode *)malloc(sizeof(EdgeNode));
                edge->adjVex = j;//邻接序号为j
                edge->weight = graph.arc[i][j];//权重赋值
                edge->next = (*graphlist)->list[i].firstEdge;//将当前顶点上的指向的结点指针赋值给edge
                (*graphlist)->list[i].firstEdge = edge;//将当前顶点的指针指向edge
                (*graphlist)->list[j].inCome++;
            }
        }
    }
}

/**
 拓扑排序
 */
void TopologicalSortingCriticalPath(GraphADJlist graphlist)
{
    EdgeNode *edge;
    int i, k, gettop;
    int top = 0;//用于栈指针下标
    int count = 0;//用于统计输出顶点的个数
    int *stack;//建栈将入度为0的顶点入栈
    stack = (int *)malloc(graphlist->numVertexs * sizeof(int));
    for (i = 0; i < graphlist->numVertexs; i++) {
        if (0 == graphlist->list[i].inCome) {//将入度为0的顶点入栈
            stack[++top] = i;
        }
    }
    top2 = 0;
    etv = (int *)malloc(graphlist->numVertexs * sizeof(int));//事件最早发生时间数组
    for (i = 0; i < graphlist->numVertexs; i++) {
        etv[i] = 0;//初始化
    }
    stack2 = (int *)malloc(graphlist->numVertexs * sizeof(int));//初始化拓扑序列栈
    while (top != 0) {
        gettop = stack[top--];
        RYQLog(@"%d -> ", graphlist->list[gettop].data);
        count++;//输出号顶点，并计数
        
        stack2[++top2] = gettop;//将弹出的顶点序号压入拓扑序列的栈
        
        for (edge = graphlist->list[gettop].firstEdge; edge; edge = edge->next) {
            k = edge->adjVex;
            if (!(--graphlist->list[k].inCome)) {//将号顶点的邻接点的入度减一，如果减一后为0，则入栈
                stack[++top] = k;
            }
            if ((etv[gettop] + edge->weight) > etv[k]) {
                //求各顶点事件的最早发生事件etv的值
                etv[k] = etv[gettop] + edge->weight;
            }
        }
    }
    if (count < graphlist->numVertexs) {
        RYQLog(@"graphList无回路");
    }else{
        RYQLog(@"graphList有回路");
    }
}

/**
 求关键路径，graphlist为有向图，输出graphlist的各项相关活动
 */
void CriticalPath(GraphADJlist graphlist)
{
    EdgeNode *edge;
    int i, gettop, k, j;
    int ete, lte;//声明活动最早发生时间和最迟发生时间的变量
    TopologicalSortingCriticalPath(graphlist);//求拓扑序列，计算数组etv和stack2的值
    ltv = (int *)malloc(graphlist->numVertexs * sizeof(int));//事件最早发生时间数组
    for (i = 0; i < graphlist->numVertexs; i++) {
        RYQLog(@"%d -> ", etv[i]);
    }
    
    while (top2 != 0) {//出栈是求ltv
        gettop = stack2[top2--];
        for (edge = graphlist->list[gettop].firstEdge; edge; edge = edge->next) {
            k = edge->adjVex;
            if (ltv[k] - edge->weight < ltv[gettop]) {
                ltv[gettop] = ltv[k] - edge->weight;
            }
        }
    }
    for (i = 0; i < graphlist->numVertexs; i++) {
        printf("%d -> ", ltv[i]);
    }
    printf("\n");
    
    for (j = 0; j < graphlist->numVertexs; j++) {//求ete,lte和关键活动
        for (edge = graphlist->list[j].firstEdge; edge; edge = edge->next) {
            k = edge->adjVex;
            ete = etv[j];//活动最早发生时间
            lte = ltv[k] - edge->weight;//活动最迟发生时间
            if (ete == lte) {//两者在关键路径上相等
                printf("<v%d - v%d> 长度:%d \n", graphlist->list[j].data, graphlist->list[k].data, edge->weight);
            }
        }
    }
}

@end
