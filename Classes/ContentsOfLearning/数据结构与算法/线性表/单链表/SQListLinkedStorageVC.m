//
//  SQListLinkedStorageVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/29.
//  Copyright © 2019 橘子. All rights reserved.
/**
 线性表的顺序存储结构需要解决的问题：
 插入删除时，需要移动大量元素
 在顺序结构中，每个数据元素只需要存储数据元素的信息就可以了。在链式存储过程中，除了要存储数据元素的信息外，还要存储它的后继元素的存储地址。把存储数据元素信息的区域称为数据域，把存储直接后继位置成为指针域。指针域中存储的信息称为指针或者链。指针域和数据域两部分信息组成数据元素的存储映像，称为结点。
 n个结点链组成一个链表，即为线性表的链式存储结构。因为此结点中只包含一个指针域，所以叫单链表。
 链表中的第一个结点的存储位置称为头指针。最后一个结点的指针为空。
 单链表的第一个结点前附设一个结点，称为头结点。
 
 头结点和头指针的区分：
 1.头指针是指向链表中第一个结点的指针。头结点是为了操作的统一方便设立的，放在第一个元素的结点之前。若链表中有头结点，那么链表中的第一个结点就是头结点了，所以头指针此刻指向的是头结点的指针。
 2.头指针具有标识作用，所以常用头指针冠以链表的名字。无论链表是否为空，头指针均不为空。头指针是链表的必要元素。
 疑问：为什么空链表一定要有头指针，个人认为链表为空表示链表存在，但是没有任何结点。头指针此刻更觉得像是存储着空链表的地址。纯属猜想
 3.链表有了头结点，在对第一元素结点前插入结点和删除第一个结点，其操作与其他结点的操作就统一了。头结点不一定是链表的必需元素。
 */

#import "SQListLinkedStorageVC.h"

/**
 线性表的单链表存储结构
 */
typedef struct Node {
    
    ElemType data;//数据域 存放本结点中的数据
    struct Node *next;//指针域 存放下一个结点的地址
    
} Node;

typedef struct Node *LinkList;//定义一个链表

@interface SQListLinkedStorageVC ()

@end

@implementation SQListLinkedStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //单链表的创建
    LinkList list;
    createListHead(&list, 20);
    //单链表的数据读取
    GetNodeElem(list, 1);
    //单链表的数据插入
    NodeListInsert(&list, 5);
    GetNodeElem(list, 5);
    //单链表的数据删除
    NodelistDelete(&list, 5);
    //清空单链表
    CleanNodeList(&list);
    GetNodeElem(list, 5);
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
void createListHead (LinkList *list, int length)
{
    
    LinkList p;
    //time()主要用来获取当前的系统时间
    //srand()函数主要用来配合rand()，函数来使用。假如没有srand()，那么每次生成的随机数都是一样的。根据时间的不同生成的随机数也不一样
    srand(time(0));
    
    *list = (LinkList)malloc(sizeof(Node));
    (*list)->next = NULL;//创建一个带头结点的空链表
    
    for (int i = 0; i < length; i++) {
        
        p = (LinkList)malloc(sizeof(Node));//生成新的结点
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
void createTailLinkList (LinkList *list, int length)
{
    LinkList p,r;
    int i;
    //time()主要用来获取当前的系统时间
    //srand()函数主要用来配合rand()，函数来使用。假如没有srand()，那么每次生成的随机数都是一样的。根据时间的不同生成的随机数也不一样
    srand(time(0));
    *list = (LinkList)malloc(sizeof(Node));//整个线性表
    r = *list;
    
    for (i = 0; i < length; i++) {
        
        p = (LinkList)malloc(sizeof(Node));//生成新的结点
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
Status GetNodeElem (LinkList list, int i)
{
    
    int j = 1;
    LinkList pList = list->next;//声明一个结点p 并让p指向链表
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
Status NodeListInsert (LinkList *list, int i)
{
    int j = 1;
    LinkList pList = *list;//声明一个结点p 并让p指向链表
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
    LinkList s = (LinkList)malloc(sizeof(Node));//生成一个新的结点s
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
Status NodelistDelete (LinkList *list, int i)
{
    int j = 1;
    LinkList p,q;
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
Status CleanNodeList(LinkList *list)
{
    LinkList p,q;
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
