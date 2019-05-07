//
//  BothWayLinkListVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/7.
//  Copyright © 2019 橘子. All rights reserved.
//

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
    
    //单链表的创建
    DoubleLinkList list;
    createDouleListHead(&list, 20);
    //单链表的数据读取
    GetDouleNodeElem(list, 1);
    //单链表的数据插入
    DouleNodeListInsert(&list, 5);
    GetDouleNodeElem(list, 5);
    //单链表的数据删除
    DouleNodelistDelete(&list, 5);
    //清空单链表
    CleanDouleNodeList(&list);
    GetDouleNodeElem(list, 5);
}

/**
 头插法 后产生的元素放在最前面
 单链表的创建:
 创建思路：
 1.声明一个结点p。
 2.初始化一个空链表list。
 3.让list的头结点的指针指向NULL，即创建一个带头结点的单链表。
 4.循环：
 生成一个新结点赋值给p
 随机生成一个数字赋值给p结点的数据域data
 将p插入到头结点和新的结点之间（头插法）
 
 
 @param list 单链表
 @param length 大小
 */
void createDouleListHead (DoubleLinkList *list, int length)
{
    
    DoubleLinkList p;
    //time()主要用来获取当前的系统时间
    //srand()函数主要用来配合rand()，函数来使用。假如没有srand()，那么每次生成的随机数都是一样的。根据时间的不同生成的随机数也不一样
    srand(time(0));
    
    *list = (DoubleLinkList)malloc(sizeof(DoubleNode));
    (*list)->next = NULL;//创建一个带头结点的空链表
    
    for (int i = 0; i < length; i++) {
        
        p = (DoubleLinkList)malloc(sizeof(DoubleNode));//生成新的结点
        p->data = rand() % 100 + 1;//生成随机数 赋值给p结点的数据域
        p->next = (*list)->next;
        (*list)->next = p;//将p插入到头结点和新的结点之间
        RYQLog(@"第%d个元素  它的值为%d", i+1, p->data);
    }
}

/**
 尾插法 创建单链表  后产生的元素放在最后面
 
 @param list 单链表
 @param length 大小
 */
void createDouleTailLinkList (DoubleLinkList *list, int length)
{
    DoubleLinkList p,r;
    int i;
    //time()主要用来获取当前的系统时间
    //srand()函数主要用来配合rand()，函数来使用。假如没有srand()，那么每次生成的随机数都是一样的。根据时间的不同生成的随机数也不一样
    srand(time(0));
    *list = (DoubleLinkList)malloc(sizeof(DoubleNode));//整个线性表
    r = *list;
    
    for (i = 0; i < length; i++) {
        
        p = (DoubleLinkList)malloc(sizeof(DoubleNode));//生成新的结点
        p->data = rand() % 100 + 1;//生成随机数 赋值给p结点的数据域
        r->next = p;//将表尾的结点指针指向新的结点
        r = p;//将新的结点赋值给表尾的结点
        
    }
    
    r->next = NULL;//表示当前链表u也结束
}

/**
 单链表的数据读取
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
    DoubleLinkList pList = list->next;//声明一个结点p 并让p指向链表
    //p不为空g或者计数器j还没有等于i的时候 循环继续。
    while (pList && j < i) {
        
        //让p指向下一个结点
        pList = pList->next;
        
        ++j;
    }
    //第i个元素不存在 抛异常
    if (!pList || j > i) {
        RYQLog(@"单链表的数据读取  没有找到该元素");
        
        return ERROR;
    }
    
    ElemType elem = pList->data;
    RYQLog(@"单链表的数据读取  elem = %d", elem);
    
    return SUCCESS;
}

/**
 单链表的数据插入
 思路：
 1.声明一个结点p指向链表的第一个结点，初始化j从1开始；
 2.当j < i时，就遍历链表，让p的指针向后移动，不断指向下一个结点，j累加1；
 3.
 
 
 @param list 结点
 @param i 下标
 @return 结果
 */
Status DouleNodeListInsert (DoubleLinkList *list, int i)
{
    int j = 1;
    DoubleLinkList pList = *list;//声明一个结点p 并让p指向链表
    //p不为空g或者计数器j还没有等于i的时候 循环继续。
    while (pList && j < i) {
        
        //让p指向下一个结点
        pList = pList->next;
        
        ++j;
    }
    //第i个元素不存在 抛异常
    if (!pList || j > i) {
        return ERROR;
    }
    
    ElemType elem = 99;//要插入的数值
    DoubleLinkList s = (DoubleLinkList)malloc(sizeof(DoubleNode));//生成一个新的结点s
    s->data = elem;//结点s数据域的赋值
    s->next = pList->next;//将p结点的next指针指向赋值给s的next指针
    pList->next = s;//将p结点的next指针指向s
    
    return SUCCESS;
}

/**
 单链表的数据删除
 删除下标为i的结点思路：
 1.声明一个结点p指向链表的第一个结点，初始化j从1开始；
 2.当j < i时，遍历链表，让p的指针向后移，不断指向下一个结点，j累加1.
 3.若到链表末尾p为空，则说明第i个元素不存在
 4.否则就是查找成功，将欲删除的结点p->next 赋值给q。
 5.单链表的删除标准语句p->next = q->next，
 6.将q结点中的数据赋值给elem
 7.释放q结点，表示成功删除
 
 @param list 单链表
 @param i 删除的下标
 @return 结果
 */
Status DouleNodelistDelete (DoubleLinkList *list, int i)
{
    int j = 1;
    DoubleLinkList p,q;
    p = *list;//结点p指向链表的第一个结点
    //在单链表中遍历寻找第i个元素
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
    //将q的g后继结点赋值给p的后集结点
    p->next = q->next;
    ElemType elem = q->data;
    RYQLog(@"单链表的数据删除   elem = %d", elem);
    free(q);
    
    return SUCCESS;
}

/**
 清空单链表
 
 @param list 单链表
 @return 删除结果
 */
Status CleanDouleNodeList(DoubleLinkList *list)
{
    DoubleLinkList p,q;
    p = (*list)->next;//p指向第一个结点
    while (p) {
        
        q = p->next;
        free(p);
        p = q;
        
    }
    (*list)->next = NULL;//头结点指针域置为空
    
    return SUCCESS;
}




@end
