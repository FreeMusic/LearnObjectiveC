//
//  BothWayLinkListVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/7.
//  Copyright © 2019 橘子. All rights reserved.
// 双向链表是在单链表的基础上添加了前驱指针
//1.Autoreleasepool 是一个由 AutoreleasepoolPage 双向链表的结构，其中 child 指向它的子 page，parent 指向它的父 page。

#import "BothWayLinkListVC.h"

typedef struct DoubleNode
{
    ElemType data;
    struct DoubleNode *prior;//直接前驱指针
    struct DoubleNode *next;//直接后继指针
    
}DoubleNode, *DoubleLinkList;

@interface BothWayLinkListVC ()

@end

@implementation BothWayLinkListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //双向链表的创建
    DoubleLinkList list;
    createDouleListHead(&list, 20);
    //双向链表的数据读取
    GetDouleNodeElem(list, 1);
    //双向链表的数据插入
    DouleNodeListInsert(&list, 5);
    GetDouleNodeElem(list, 5);
    //双向链表的数据删除
    DouleNodelistDelete(&list, 5);
    //清空双向链表
    CleanDouleNodeList(&list);
    GetDouleNodeElem(list, 5);
}

/**
 头插法 后产生的元素放在最前面
 
 @param list 双向链表
 @param length 大小
 */
void createDouleListHead (DoubleLinkList *list, int length)
{
    
    DoubleLinkList p;
    //time()主要用来获取当前的系统时间
    //srand()函数主要用来配合rand()，函数来使用。假如没有srand()，那么每次生成的随机数都是一样的。根据时间的不同生成的随机数也不一样
    srand(time(0));
    
    *list = (DoubleLinkList)malloc(sizeof(DoubleNode));
    (*list)->next = *list;
    (*list)->prior = *list;
    
    for (int i = 0; i < length; i++) {
        
        p = (DoubleLinkList)malloc(sizeof(DoubleNode));//生成新的结点
        p->data = rand() % 100 + 1;//生成随机数 赋值给p结点的数据域
        p->next = (*list)->next;
        p->prior = (*list);
        (*list)->next->prior = p;
        (*list)->next = p;//将p插入到头结点和新的结点之间
    }
}

/**
 双向链表的数据读取
 获取链表第i个数据的思路:通过下标i，比方要查找第4个数据。从第一个开始通过next指针，找到第二个数据。再通过第二个数据的next指针找到第三个数据。最后通过第三个数据的next指针找到第四个数据。
 1.声明一个结点p指向链表的y第一个结点，初始化j从1开始。
 2.当j < i时，就遍历链表，让p的指针向后移动，不断指向下一个结点，j累加1.
 3.若到链表末尾p为空，则说明第i个元素不存在；
 4.若查找成功，返回结点p的数据
 时间复杂度O（n）
 
 @param list 结点
 @param i 下标
 @return 结果
 */
Status GetDouleNodeElem (DoubleLinkList list, int i)
{
    
    int j = 1;
    DoubleLinkList p = list->next;//声明一个结点p 并让p指向链表
    //p不为空g或者计数器j还没有等于i的时候 循环继续。
    while (p && j < i) {
        
        //让p指向下一个结点
        p = p->next;
        
        ++j;
    }
    //第i个元素不存在 抛异常
    if (!p || j > i) {
        RYQLog(@"双向链表的数据读取  没有找到该元素");
        
        return ERROR;
    }
    
    ElemType elem = p->data;
    RYQLog(@"双向链表的数据读取  elem = %d", elem);
    
    return SUCCESS;
}

/**
 双向链表的数据插入
 
 @param list 结点
 @param i 下标
 @return 结果
 */
Status DouleNodeListInsert (DoubleLinkList *list, int i)
{
    int j = 1;
    DoubleLinkList p = *list;//声明一个结点p 并让p指向链表
    //p不为空g或者计数器j还没有等于i的时候 循环继续。
    while (p && j < i) {
        
        //让p指向下一个结点
        p = p->next;
        
        ++j;
    }
    //第i个元素不存在 抛异常
    if (!p || j > i) {
        return ERROR;
    }
    
    ElemType elem = 99;//要插入的数值
    DoubleLinkList s = (DoubleLinkList)malloc(sizeof(DoubleNode));//生成一个新的结点s
    s->data = elem;//结点s数据域的赋值
    s->prior = p;//把p结点赋值给s的前置指针
    s->next = p->next;//将p结点的next指针指向赋值给s的next指针
    p->next->prior = s;//s结点赋值给p结点的next的前置指针
    p->next = s;//将p结点的next指针指向s
    
    return SUCCESS;
}

/**
 双向链表的数据删除
 
 @param list 双向链表
 @param i 删除的下标
 @return 结果
 */
Status DouleNodelistDelete (DoubleLinkList *list, int i)
{
    int j = 1;
    DoubleLinkList p,q;
    p = *list;//结点p指向链表的第一个结点
    //在双向链表中遍历寻找第i个元素
    while (j < i && p->next) {
        
        p = p->next;
        ++j;
        
    }
    //查找的元素不存在
    if (j > i || !(p->next)) {
        return ERROR;
    }
    //查找的元素存在  此时p结点为找到的第i-1个元素 q结点为第i个元素
    q = p->next;
    q->prior->next = q->next;//将q的后继结点赋值给q的前置结点的后指针
    q->next->prior = q->prior;//将q的前置结点赋值给q的后置结点的前指针
    ElemType elem = q->data;
    RYQLog(@"双向链表的数据删除   elem = %d", elem);
    free(q);
    
    return SUCCESS;
}

/**
 清空双向链表
 
 @param list 双向链表
 @return 删除结果
 */
Status CleanDouleNodeList(DoubleLinkList *list)
{
    DoubleLinkList p,q;
    p = (*list)->next;//p指向第一个结点
    while (p != *list) {
        
        q = p->next;
        free(p);
        p = q;
        
    }
    (*list)->next = (*list)->prior = NULL;//头结点指针域置为空
    
    return SUCCESS;
}

/**
 销毁双向链表

 @param list 双向链表
 @return 结果
 */
Status DestroyDouleNodeList(DoubleLinkList *list)
{
    DoubleLinkList p,q;
    p = (*list)->next;//p指向第一个结点
    while (p != *list) {
        
        q = p->next;
        free(p);
        p = q;
        
    }
    free(list);
    list = NULL;
    
    return SUCCESS;
}


@end
