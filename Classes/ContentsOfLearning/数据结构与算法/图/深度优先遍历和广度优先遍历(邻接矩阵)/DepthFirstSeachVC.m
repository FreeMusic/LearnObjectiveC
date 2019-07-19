

//
//  DepthFirstSeachVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/18.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 图的遍历：从图中某一顶点出发访问图中其余顶点，且使每一个顶点仅被访问一次，这一过程就叫图的遍历。
 深度优先遍历是一个递归的过程，就像一棵树的前序遍历。它从图中某个顶点V出发，访问此顶点，然后从V的未被访问的邻接点出发深度优先遍历图，直至图中所有和V有路径相通的顶点都被访问到。DFS（又称深度优先搜索）
 事实上，我们这里讲到的是连通图，对于非连通图，只需要对它的连通分量分别进行深度优先遍历，即在先前一个顶点进行一次深度优先遍历后，若图中尚有顶点未被访问到，则另选图中一个未曾被访问的顶点作为起始点，重复上述过程，直到图中所有顶点都被访问到为止。
 广度优先遍历又称为广度优先搜索。BFS，如果说图的深度优先遍历类似树的前序遍历，那么图的广度优先遍历类似于树的层序遍历。
 */
#import "DepthFirstSeachVC.h"

#define MaxSize 9 //存储空间初始分配量
#define MaxEdge 15
#define MaxVex 9
#define Infinity 65535
#define YQYES 1
#define YQNO 0

typedef int BOOLEAN;//BOOLEAN是布尔类型，其值是true或false

typedef char VertexType;//顶点类型
typedef char VertexTypeStrings[MaxSize];
typedef int EdgeType;//边上的权值类型

typedef struct {
    VertexType vexs[MaxVex];//顶点表
    EdgeType arc[MaxVex][MaxVex];//邻接矩阵 可看作边表
    int numVertexs, numEdges;//图中当前顶点数和边数
}MGraph;

/**
 循环队列的顺序存储结构
 */
typedef struct {
    int data[MaxSize];
    int front;//头指针
    int rear;//尾指针，若队列不空，指向队列尾元素的下一个位置
}SequentialCycleQueue;

BOOLEAN visited[MaxVex];//访问标志的数组

@interface DepthFirstSeachVC ()

@end

@implementation DepthFirstSeachVC


/**
 空队列的初始化
 
 @param queue 空队列
 */
void initCycleQueue(SequentialCycleQueue *queue)
{
    queue->front = 0;
    queue->rear = 0;
}

/**
 判断该队列是否为空
 
 @param queue 队列
 @return 判断结果 SUCCESS为空  ERROR不为空
 */
Status CycleQueueEmpty(SequentialCycleQueue queue)
{
    if (queue.front == queue.rear) {
        return SUCCESS;
    }else{
        return ERROR;
    }
}

/**
 判断队列是否已满
 
 @param queue 队列
 @return YES 已满  NO 未满
 */
BOOL QueueFull(SequentialCycleQueue *queue)
{
    return ((queue->rear+1)%MaxSize == queue->front);
}

/**
 向队列插入新元素elem
 
 @param queue 队列
 @param elem 新元素elem
 @return 状态
 */
Status EnterCycleQueue(SequentialCycleQueue *queue, int elem)
{
    if (QueueFull(queue)) {//队列已满
        return ERROR;
    }
    queue->data[queue->rear] = elem;//将元素elem赋值给队尾
    queue->rear = (queue->rear+1)%MaxSize;//rear指针向后移动一个位置
    
    return SUCCESS;
}

/**
 若队列不为空，则删除queue中队头元素，用elem返回其值

 @param queue 队列
 @param elem 删除的元素
 */
void deleteCycleQueue(SequentialCycleQueue *queue, int *elem)
{
    if (queue->front == queue->rear) {//队列不为空  不作任何操作
        return;
    }
    
    *elem = queue->data[queue->front];//将队头元素赋值给elem
    queue->front = (queue->front+1)%MaxSize;//front指针向后移一个位置，若到最后则转到数组头部
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGraph graph;
    CreateMGraph(&graph);
    //深度优先遍历
    depthFirstSearchTraverse(graph);
    //邻接矩阵的广度遍历算法
    breadthFirstSearchTraverse(graph);
}

/**
 创建邻接矩阵
 
 @param graph 初始化的邻接矩阵
 */
void CreateMGraph(MGraph *graph)
{
    int i, j;
    graph->numEdges = 15 ;
    graph->numVertexs = 9;
    
    //读入顶点信息建立顶点表
    char *vexChars = "ABCDEFGHI";
    for (int k = 0; k < strlen(vexChars); k++) {
        graph->vexs[k] = *(vexChars+k);
    }
    
    for (i = 0; i < graph->numVertexs; i++) {//初始化图
        for (j = 0; j < graph->numVertexs; j++) {
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
    
    for (i = 0; i < graph->numVertexs; i++) {
        for (j = i; j < graph->numVertexs; j++) {
            graph->arc[j][i] = graph->arc[i][j];
        }
    }
}

/**
 邻接矩阵的深度遍历操作
 
 @param graph 邻接矩阵
 */
void depthFirstSearchTraverse(MGraph graph)
{
    int i;
    for (i = 0; i < graph.numVertexs; i++) {
        visited[i] = YQNO;//初始的所有顶点状态都是未访问过的状态
    }
    RYQLog(@"邻接矩阵的深度遍历操作");
    for (i = 0; i < graph.numVertexs; i++) {
        if (!visited[i]) {//对未访问过的顶点调用DFS，若是连通图，只会调用一次
            depthFirstSearch(graph, i);
        }
    }
}

/**
 邻接矩阵的深度优先递归算法
 
 @param graph 邻接矩阵
 */
void depthFirstSearch(MGraph graph, int i)
{
    int j;
    visited[i] = YQYES;
    
    RYQLog(@"%c", graph.vexs[i]);//打印顶点 或者 做其他操作
    for (j = 0; j < graph.numVertexs; j++) {
        if (graph.arc[i][j] == 1 && !visited[j]) {
            depthFirstSearch(graph, j);//对为访问的邻接顶点递归调用
        }
    }
}

/**
 邻接矩阵的广度遍历算法
 
 @param graph 邻接矩阵
 */
void breadthFirstSearchTraverse(MGraph graph)
{
    int i, j;
    SequentialCycleQueue queue;
    for (i = 0; i < graph.numVertexs; i++) {//初始的所有顶点状态都是未访问过的状态
        visited[i] = YQNO;
    }
    RYQLog(@"邻接矩阵的广度遍历算法");
    initCycleQueue(&queue);//初始化辅助用的队列
    
    for (i = 0; i < graph.numVertexs; i++) {//遍历每一个顶点
        
        if (!visited[i]) {
            visited[i] = YQYES;//标识该顶点已经访问过
            RYQLog(@"%c", graph.vexs[i]);//打印顶点，也可以其他操作
            EnterCycleQueue(&queue, i);//将此顶点入队列
            while (!CycleQueueEmpty(queue)) {//如果队列不为空
                deleteCycleQueue(&queue, &i);//将队列元素出队列，赋值给i
                for (j = 0; j < graph.numVertexs; j++) {
                    //判断其他顶点若与当前顶点存在并且未被访问过
                    if (graph.arc[i][j] == 1 && !visited[j]) {
                        visited[j] = YQYES;
                        RYQLog(@"%c", graph.vexs[j]);//打印顶点，也可以其他操作
                        EnterCycleQueue(&queue, j);
                    }
                }
            }
        }
        
    }
}

@end
