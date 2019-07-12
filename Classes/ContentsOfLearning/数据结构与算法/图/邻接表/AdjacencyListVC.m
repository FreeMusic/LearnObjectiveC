//
//  AdjacencyListVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 邻接矩阵是不错的一种图存储结构，但对于边数相对较少的图，这种结构s会存在存储空间的极大浪费。引用链式存储结构来避免存储空间的浪费。
 数组和链表相结合的存储方法称为邻接表。
 邻接表的处理方法：
 1.图中顶点用一个一位数组存储。另外对于顶点数组中，每个数据元素还需要存储指向第一个邻接点的指针，以便于寻找该结点边的信息。
 2.图中每个顶点Vi的所有邻接点构成一个线性表，由于邻接点的个数不稳定，所以用单链表来存储，无向图称为顶点Vi的边表，有向图则称为顶点Vi作为弧尾的出边表。
 */
#import "AdjacencyListVC.h"

#define MaxVex 100//最大顶点数，由用户自定义

typedef char VertexType;//顶点类型
typedef int EdgeType;//边的权值类型

typedef struct EdgeNode{//边表结点
    int adjvex;//邻接点域，存储该顶点对应的下标
    EdgeType info;//用于存储权值，对于非网图可以不需要
    struct EdgeNode *next;//链域，指向下一个邻接点
}EdgeNode;

typedef struct VertexNode{//顶点表结点
    VertexType data;//顶点域，存储顶点信息
    EdgeNode *firstEdge;//边表头指针
}VertexNode, ADJlist[MaxVex];

typedef struct {//图的邻接表
    ADJlist list;//邻接表
    int numNodes, numEdges;//图中当前顶点数和边数
}GraphADJlist;

@interface AdjacencyListVC ()

@end

@implementation AdjacencyListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    GraphADJlist graph;//创建一个图的邻接表变量
    //建立图的邻接表结构
    CreateGraphADJlist(&graph, 4, 6);
}

/**
 建立图的邻接表结构

 @param graph 图的邻接表
 */
void CreateGraphADJlist(GraphADJlist *graph, int numNodes, int numEdges)
{
    int i, j, k;
    EdgeNode *edge;
    //自定义顶点数和边数
    graph->numNodes = numNodes;
    graph->numEdges = numEdges;
   
    for (i = 0; i < graph->numNodes; i++) {//读入顶点信息，建立顶点表
        graph->list[i].data = i;//顶点的信息
        graph->list[i].firstEdge = NULL;//将边表置为空表
    }
    
    //生成有向边 顶点序号 (0,1)、(0,2)、(2,1)、(2,3)、(3,0)、(3,1)
    NSArray *ilists = @[
                        @(0),
                        @(0),
                        @(2),
                        @(2),
                        @(3),
                        @(3),
                        ];
    NSArray *jlists = @[
                        @(1),
                        @(2),
                        @(1),
                        @(3),
                        @(0),
                        @(1),
                        ];
    
    for (k = 0; k < graph->numEdges; k++) {//建立边表
        j = [jlists[k] intValue];
        i = [ilists[k] intValue];
        edge = (EdgeNode *)malloc(sizeof(EdgeNode));//申请内存空间，生成边表结点
        edge->adjvex = j;//邻接序号为j
        edge->next = graph->list[i].firstEdge;//将edge的next指针指向当前顶点上指向的结点
        graph->list[i].firstEdge = edge;//将当前顶点的指针指向edge
        
        edge = (EdgeNode *)malloc(sizeof(EdgeNode));//申请内存空间，生成边表结点
        edge->adjvex = i;//邻接序号为i
        edge->next = graph->list[j].firstEdge;//将edge的next指针指向当前顶点上指向的结点
        graph->list[j].firstEdge = edge;//将当前顶点的指针指向edge
    }
}

@end
