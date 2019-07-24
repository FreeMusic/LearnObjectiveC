//
//  BreadthFirstSearchVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "BreadthFirstSearchVC.h"

#define MaxSize 9 //存储空间初始分配量
#define MaxEdges 15//图的最大边数
#define MaxVex 9//最大顶点数
#define Infinity 65535
#define YQYES 1
#define YQNO 0

typedef int BOOLEAN;//BOOLEAN是布尔类型，其值是YQYES或YQNO

typedef char VertexType;//顶点类型
typedef int EdgeType;//边上的权值

/**
 邻接矩阵结构
 */
typedef struct {
    VertexType vexs[MaxVex];//顶点表
    EdgeType arc[MaxVex][MaxVex];//邻接矩阵 可看做表
    int numVertexes, numEdges;//图中当前的顶点数和边数
}MGraph;

/**
 邻接表的结构
 */
typedef struct EdgeNode {//边表结点
    int adjVex;//邻接点域 存储该顶点对应的下标
    int weight;//用于存储权值，对于非网图可以不需要
    struct EdgeNode *next;//链域，指向下一个邻接点
}EdgeNode;

/**
 顶点表结点
 */
typedef struct VertexNode {
    int inVex;//顶点表入度
    char data;//顶点域 存储顶点信息
    EdgeNode *firstEdge;//边表头指针
}VertexNode, ADJlist[MaxVex];

typedef struct{
    ADJlist list;
    int numVertexes, numEdges;//图中当前顶点数和边数
}graphADJlist, *GraphADJlist;

typedef struct
{
    int data[MaxSize];//
    int front;//头指针
    int rear;//尾指针，若队列不空，指向队列尾元素的下一个位置
}CyclelistQueue;

BOOLEAN hasVisited[MaxVex];//访问标志的数组

@interface BreadthFirstSearchVC ()

@end

@implementation BreadthFirstSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    
=======

>>>>>>> 46b73da98ae5e08eb59add56bb503c410fe9b6e4
    MGraph graph;
    GraphADJlist list;
    //构建邻接矩阵
    CreateADJMGraph(&graph);
    //利用邻接矩阵构建邻接表
    CreateALGraph(graph, &list);
    //邻接表的深度遍历
    DepthFirstSearchlist(list);
    ///广度遍历
    BreadthFirstSearchTravellist(list);
}

/**
 初始化一个空队列

 @param queue 队列
 */
void initCyclelistQueue(CyclelistQueue *queue){
    queue->front = 0;
    queue->rear = 0;
}

/**
 判断该队列是否为空队列

 @param queue 队列
 @return YES 空队列；NO 非空队列；
 */
BOOL CyclelistQueueEmpty(CyclelistQueue *queue)
{
    return (queue->front == queue->rear);
}

/**
 判断该队列是否已满

 @param queue 队列
 @return YES 已满；NO 未满；
 */
BOOL CyclelistQueueFull(CyclelistQueue *queue)
{
    return ((queue->rear+1)%MaxSize == queue->front);//队列是否已满
}

/**
 向队列中添加元素

 @param queue 队列
 @param elem 元素
 */
void EnterCyclelistQueue(CyclelistQueue *queue, int elem)
{
    if (CyclelistQueueFull(queue)) {//判断队列是否已满
        return;
    }
    
    queue->data[queue->rear] = elem;//将元素elem赋值给队尾
    queue->rear = (queue->rear+1)%MaxSize;//rear指针向后移一个位置
}

/**
 删除队列中的某个元素

 @param queue 队列
 @param elem 某个元素
 */
void DeleteCyclelistQueue(CyclelistQueue *queue, int *elem)
{
    if (CyclelistQueueEmpty(queue)) {//如果队列为空
        return;
    }
    
    *elem = queue->data[queue->front];//将队头元素赋值给elem
    queue->front = (queue->front+1)%MaxSize;//front指针向后移动一个位置
}

/**
 创建邻接矩阵
 
 @param graph 初始化的邻接矩阵
 */
void CreateADJMGraph(MGraph *graph){
    
    int i, j;
    graph->numEdges = MaxEdges;
    graph->numVertexes = MaxVex;
    
    //读入顶点信息，建立顶点表
    char *vexChars = "ABCDEFGHI";
    for (int k = 0; k < strlen(vexChars); k++) {
        graph->vexs[k] = *(vexChars+k);
    }
    
    for (i = 0; i < graph->numVertexes; i++) {//初始化图
        for (j = 0; j < graph->numVertexes; j++) {
            graph->arc[i][j] = 0;
        }
    }
    
    graph->arc[0][1] = 1;
    graph->arc[0][5] = 1;
    
    graph->arc[1][2] = 1;
    graph->arc[1][8] = 1;
    graph->arc[1][6] = 1;
    
    graph->arc[2][3] = 1;
    graph->arc[2][8] = 1;
    
    graph->arc[3][4] = 1;
    graph->arc[3][7] = 1;
    graph->arc[3][6] = 1;
    graph->arc[3][8] = 1;
    
    graph->arc[4][5] = 1;
    graph->arc[4][7] = 1;
    
    graph->arc[5][6] = 1;
    
    graph->arc[6][7] = 1;
    
    for (i = 0; i < graph->numVertexes; i++) {
        for (j = i; j < graph->numVertexes; j++) {
            graph->arc[j][i] = graph->arc[i][j];
        }
    }
}

/**
 利用邻接矩阵构建邻接表

 @param graph 邻接矩阵
 @param list 邻接表
 */
void CreateALGraph(MGraph graph, GraphADJlist *list)
{
    int i, j;
    EdgeNode *edge;
    
    *list = (GraphADJlist)malloc(sizeof(graphADJlist));//
    
    (*list)->numVertexes = graph.numVertexes;
    (*list)->numEdges = graph.numEdges;
    
    for (i = 0; i < graph.numVertexes; i++) {//读入顶点信息，建立顶点表
        (*list)->list[i].inVex = 0;
        (*list)->list[i].data = graph.vexs[i];
        (*list)->list[i].firstEdge = NULL;//将边表置为空
    }
    
    for (i = 0; i < graph.numVertexes; i++) {//建立边表
        for (j = 0; j < graph.numVertexes; j++) {
            if (graph.arc[i][j] == 1) {
                edge = (EdgeNode *)malloc(sizeof(EdgeNode));
                edge->adjVex = j;//邻接序号为j
                edge->next = (*list)->list[i].firstEdge;//将当前顶点上的指向的结点指针赋值给edge
                (*list)->list[i].firstEdge = edge;
                (*list)->list[j].inVex++;
            }
        }
    }
}

/**
 邻接表的深度优先递归算法

 @param list 邻接表
 @param i i
 */
void DepthFirstSearchAlgorithmRecursive(GraphADJlist list, int i)
{
    EdgeNode *node;
    hasVisited[i] = YQYES;//
    node = list->list[i].firstEdge;
    RYQLog(@"%c", list->list[i].data);//打印顶点
    while (node) {
        if (!hasVisited[node->adjVex]) {
            DepthFirstSearchAlgorithmRecursive(list, node->adjVex);
        }
        node = node->next;
    }
}

/**
 深度遍历

 @param list 邻接表
 */
void DepthFirstSearchlist(GraphADJlist list)
{
    int i;
    RYQLog(@"邻接表的深度遍历");
    for (i = 0; i < list->numVertexes; i++) {
        hasVisited[i] = YQNO;//初始所有顶点状态都是未访问过的状态
    }
    for (i = 0; i < list->numVertexes; i++) {
        if (!hasVisited[i]) {
            DepthFirstSearchAlgorithmRecursive(list, i);
        }
    }
}

/**
 广度遍历

 @param list 邻接表
 */
void BreadthFirstSearchTravellist(GraphADJlist list)
{
    int i;
    EdgeNode *node;//
    CyclelistQueue queue;
    for (i = 0; i < list->numVertexes; i++) {
        hasVisited[i] = YQNO;
    }
    RYQLog(@"邻接表的广度遍历");
    initCyclelistQueue(&queue);
    for (i = 0; i < list->numVertexes; i++) {
        if (!hasVisited[i]) {
            hasVisited[i] = YQYES;
            RYQLog(@"%c", list->list[i].data);
            EnterCyclelistQueue(&queue, i);
            while (!CyclelistQueueEmpty(&queue)) {
                DeleteCyclelistQueue(&queue, &i);
                node = list->list[i].firstEdge;//找到当前顶点的边表链表头指针
                while (node) {
                    if (!hasVisited[node->adjVex]) {//如果顶点未被访问
                        hasVisited[node->adjVex] = YQYES;
                        RYQLog(@"%c", list->list[node->adjVex].data);
                        EnterCyclelistQueue(&queue, node->adjVex);
                    }
                    node = node->next;//指针指向下一个邻接点
                }
            }
        }
    }
}

@end
