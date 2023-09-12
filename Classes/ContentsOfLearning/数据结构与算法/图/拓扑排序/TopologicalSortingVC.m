//
//  TopologicalSortingVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 拓扑排序主要解决一个工程能否顺利进行的问题
 在一个表示工程的有向图中，用顶点表示活动，用弧表示活动之间的优先关系，这样的有向图为顶点表示活动的网，我们称为AOV网(Activity On Vertex Network)
 */
#import "TopologicalSortingVC.h"

#define MaxEdge 20
#define MaxVex 14
#define Infinity 65535

/**
 邻接矩阵结构
 */
typedef struct {
    int vexs[MaxVex];//顶点表
    int arc[MaxVex][MaxVex];//邻接矩阵 可看作边表
    int numVertexes, numEdges;
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
    EdgeNode *firstEdge;//边表头指针
}VertexNode, ADJlist[MaxVex];

typedef struct
{
    ADJlist list;//
    int numVertexs, numEdges;//当前顶点数和边数
}graphADJlist, *GraphADJlist;

@interface TopologicalSortingVC ()



@end

@implementation TopologicalSortingVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    MGraph graph;
    GraphADJlist graphList;
    //构建图
    CreateSortingMGraph(&graph);
    //利用邻接矩阵构建邻接表
    CreateSortingALGraph(graph, &graphList);
    //拓扑排序
    TopologicalSorting(graphList);
}

/**
 构建图
 */
void CreateSortingMGraph(MGraph *graph)
{
    int i, j;
    
    graph->numEdges = MaxEdge;
    graph->numVertexes = MaxVex;
    
    for (i = 0; i < graph->numVertexes; i++) {//初始化图
        graph->vexs[i] = i;
    }
    
    for (i = 0; i < graph->numVertexes; i++) {
        for (j = 0; j < graph->numVertexes; j++) {
            graph->arc[i][j] = 0;
        }
    }
    
    //两点之间路径长度的赋值
    graph->arc[0][4] = 1;
    graph->arc[0][5] = 1;
    graph->arc[0][11] = 1;
    graph->arc[1][2] = 1;
    graph->arc[1][4] = 1;
    graph->arc[1][8] = 1;
    graph->arc[2][5] = 1;
    graph->arc[2][6] = 1;
    graph->arc[2][9] = 1;
    graph->arc[3][2] = 1;
    graph->arc[3][13] = 1;
    graph->arc[4][7] = 1;
    graph->arc[5][12] = 1;
    graph->arc[6][5] = 1;
    graph->arc[8][7] = 1;
    graph->arc[4][7] = 1;
    graph->arc[9][10] = 1;
    graph->arc[9][11] = 1;
    graph->arc[10][13] = 4;
    graph->arc[12][9] = 4;
}

/**
 利用邻接矩阵构建邻接表
 */
void CreateSortingALGraph(MGraph graph, GraphADJlist *graphList)
{
    int i, j;
    EdgeNode *edge;
    
    *graphList = (GraphADJlist)malloc(sizeof(graphADJlist));
    
    (*graphList)->numVertexs = graph.numVertexes;
    (*graphList)->numEdges = graph.numEdges;
    
    for (i = 0; i < graph.numVertexes; i++) {
        //读入顶点信息，建立顶点表
        (*graphList)->list[i].inCome = 0;
        (*graphList)->list[i].data = graph.vexs[i];
        (*graphList)->list[i].firstEdge = NULL;//将边表置为空
    }
    
    for (i = 0; i < graph.numVertexes; i++) {//建立边表
        for (j = 0; j < graph.numVertexes; j++) {
            if (graph.arc[i][j] == 1) {
                edge = (EdgeNode *)malloc(sizeof(EdgeNode));
                edge->adjVex = j;//邻接序号为j
                edge->next = (*graphList)->list[i].firstEdge;//将当前顶点上的指向的结点指针赋值给edge
                (*graphList)->list[i].firstEdge = edge;//将当前d顶点的指针指向edge
                (*graphList)->list[j].inCome++;
            }
        }
    }
}
/**
 拓扑排序 若graphList无回路，则输出拓扑排序序列并返回1，若有回路返回0
 */
void TopologicalSorting(GraphADJlist graphList)
{
    EdgeNode *edge;
    int i, k, gettop;
    int top = 0;//用于栈指针下标
    int count = 0;//用于统计输出顶点的个数
    int *stack;//建栈将入度为0的顶点入栈
    stack = (int *)malloc(graphList->numVertexs*sizeof(int));

    for (i = 0; i < graphList->numVertexs; i++) {
        if (0 == graphList->list[i].inCome) {
            //将入度为0的顶点入栈
            stack[++top] = i;
        }
    }
    NSString *description = @"";
    while (top != 0) {
        gettop = stack[top--];
        description = [NSString stringWithFormat:@"%@%d -> ", description, graphList->list[gettop].data];
        count++;//输出i号顶点并计数
        for (edge = graphList->list[gettop].firstEdge; edge; edge = edge->next) {
            k = edge->adjVex;
            if (!(--(graphList->list[k].inCome))) {//将i号顶点的邻接点入度减一，如果减一后为0，则入栈
                stack[++top] = k;
            }
        }
    }
    XYLog(@"%@", description);
    if (count < graphList->numVertexs) {
        XYLog(@"graphList无回路");
    }else{
        XYLog(@"graphList有回路");
    }
}

@end
