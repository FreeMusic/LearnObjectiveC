//
//  QueueVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/23.
//  Copyright © 2019 橘子. All rights reserved.
//  队列也是线性表，只许在一头插入，另一头删除 先进先出

#import "QueueVC.h"

/**
 队列de结点结构
 */
typedef struct QueueNode{
    ElemType data;
    struct QueueNode *next;
}QueueNode, *QueuePtr;

/**
 队列的链表结构
 */
typedef struct {
    QueuePtr front,rear;//队头队尾指针
}LinkQueue;

@interface QueueVC ()

@end

@implementation QueueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LinkQueue queue;
    initQueue(&queue, 10);
    EnterQueue(&queue, 44);
    ExitQueue(&queue);
    cleanQueue(&queue);
    travelQueue(&queue);
}

/**
 队列的初始化

 @param queue 队列
 */
void initQueue(LinkQueue *queue, int size)
{
    queue->front = queue->rear = (QueuePtr)malloc(sizeof(QueueNode));
    if (size == 0) {
        queue->front->next = NULL;
        return;
    }
    
    for (int i = 0; i < size; i++) {
        EnterQueue(queue, (i+1)*10);
    }
}

/**
 队列的入队操作 (入队操作只能在队尾进行)

 @param queue 队列
 @param data 入队的元素de 数据
 @return 结果
 */
Status EnterQueue(LinkQueue *queue, ElemType data)
{
    //创建新的入队元素
    QueuePtr elem = (QueuePtr)malloc(sizeof(QueueNode));
    if (!elem) {
        exit(OVERFLOW);//内存分配失败，exit()函数的功能为，退出当前运行的程序，并将参数value返回给主调进程，在main中return v;的效果 与exit(v);相同。OVERFLOW为math.h中的一个宏定义，其值为3。含义为运算过程中出现了上溢，即运算结果超出了运算变量所能存储的范围。
    }
    elem->data = data;
    elem->next = NULL;//创建的元素会作为队尾的最后一个元素，它的后置指针必然指向空
    queue->rear->next = elem;//此时队尾的最后一个元素，将其next后置指针指向新元素elem
    queue->rear = elem;//组成的新队列，队列的队尾指针指向新元素elem
    
    return SUCCESS;
}

/**
 队列的出队操作 （出队操作只能在队头执行）

 @param queue 队列
 @return 结果
 */
Status ExitQueue(LinkQueue *queue)
{
    //队列为空
    if (QueueEmpty(queue)) {
        return ERROR;
    }
    QueuePtr elem = queue->front->next;
    queue->front->next = elem->next;
    elem->next = NULL;
    if (queue->rear == elem) {
        queue->rear = queue->front;
    }
    free(elem);
    
    return SUCCESS;
}


/**
 队列是否为空

 @param queue 队列
 @return bool
 */
bool QueueEmpty(LinkQueue *queue)
{
    return (queue->front == queue->rear);
}

void travelQueue(LinkQueue *queue)
{
    //队列为空
    if (QueueEmpty(queue)) {
        return;
    }
    
    QueuePtr elem = queue->front->next;
    
    while (elem) {
        RYQLog(@"elem = %d", elem->data);
        elem = elem->next;
    }
}

void cleanQueue(LinkQueue *queue)
{
    //队列为空
    if (QueueEmpty(queue)) {
        return;
    }
    QueuePtr elem = queue->front->next;
    QueuePtr p;
    while (elem) {
        p = elem;
        elem = elem->next;
        if (queue->rear == elem) {
            queue->rear = queue->front;
        }
        
        free(p);
    }
    
}

@end
