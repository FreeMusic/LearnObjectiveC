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
 2.头指针h具有标识作用，所以常用头指针冠以链表的名字。无论链表是否为空，头指针均不为空。头指针是链表的必要元素。
 疑问：为什么空链表一定要有头结点，个人认为链表为空表示链表存在，但是没有任何结点。头指针此刻更觉得像是存储着空链表的地址。纯属猜想
 3.链表有了头结点，在对第一元素结点前插入结点和删除第一个结点，其操作与其他结点的操作就统一了。头结点不一定是链表的必需元素。
 */

#import "SQListLinkedStorageVC.h"

typedef int ElemType;//int类型的数据

typedef NS_ENUM(NSUInteger, Status) {

    ERROR = 0,//失败或者报错
    SUCCESS = 1,//成功

};

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

    
}

/**
 单链表的数据读取
 获取链表第i个数据的思路:
 1.声明一个结点p指向链表的y第一个结点，初始化j从1开始。
 2.当j < i时，就遍历链表，让p的指针向后移动，不断指向下一个结点，j累加1.
 3.若到链表末尾p为空，则说明第i个元素不存在；
 4.若查找成功，返回结点p的数据
 时间复杂度O（n）

 @param list 结点
 @param i 下标
 @param elem 数据
 @return 结果
 */
Status GetNodeElem (LinkList list, int i, ElemType elem)
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
        return ERROR;
    }
    
    elem = pList->data;

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
 @param elem 数据
 @return 结果
 */
Status NodeListInsert (LinkList list, int i, ElemType elem)
{
    
    
    return SUCCESS;
}

@end
