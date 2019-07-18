

//
//  DepthFirstSeachVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/18.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 图的遍历：从图中某一顶点出发访问图中其余顶点，且使每一个顶点仅被访问一次，这一过程就叫图的遍历。
 深度优先遍历是一个递归的过程，就像一棵树的前序遍历。它从图中某个顶点V出发，访问此顶点，然后从V的未被访问的邻接点出发深度优先遍历图，直至图中所有和V有路径相通的顶点都被访问到。
 事实上，我们这里讲到的是连通图，对于非连通图，只需要对它的连通分量分别进行深度优先遍历，即在先前一个顶点进行一次深度优先遍历后，若图中尚有顶点未被访问到，则另选图中一个未曾被访问的顶点作为起始点，重复上述过程，直到图中所有顶点都被访问到为止。
 */
#import "DepthFirstSeachVC.h"

#define MaxSize 9 //存储空间初始分配量
#define MaxEdge 15
#define MaxVex 9
#define Infinity 65535

typedef char VertexType;//顶点类型
typedef char VertexTypeStrings[MaxSize];
typedef int EdgeType;//边上的权值类型



typedef struct {
    VertexType vexs[MaxVex];//顶点表
    EdgeType arc[MaxVex][MaxVex];//邻接矩阵 可看作边表
    int numVertexs, numEdges;//图中当前顶点数和边数
}MGraph;



@interface DepthFirstSeachVC ()

@end

@implementation DepthFirstSeachVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    MGraph graph;
    CreateMGraph(&graph);
}

void CreateMGraph(MGraph *graph)
{
    int i, j;
    graph->numEdges = 15;
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
    
    
}

@end
