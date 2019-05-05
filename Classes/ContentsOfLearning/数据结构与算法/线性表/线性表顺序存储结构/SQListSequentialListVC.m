//
//  SQListSequentialListVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/29.
//  Copyright © 2019 橘子. All rights reserved.
//  数组的长度是存放线性表的存储空间的长度
//  线性表的长度是线性表中数据元素的个数，随着线性表的增删改查，线性表的长度是有变化的。
//  在任意时刻，线性表的长度该小于等于数组的长度

#import "SQListSequentialListVC.h"

#define MAXSIZE 20 //存储空间初始化分配量 线性表的最大长度

typedef struct SQList {
    
    ElemType data[MAXSIZE];//数组存储数据元素 最大值为MAXSIZE 数组data，它的存储位置就是存储空间的存储位置
    int length; //线性表当前长度
    int listSize;//数组的最大长度
    
}SQList;


@interface SQListSequentialListVC ()

@end

@implementation SQListSequentialListVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    //初始化线性表
    SQList list = initSequentialList(20);
    travelWholeList(list);
//    //获得链表元素操作
//    GetElem(list, 3);
//    //线性表的插入操作
//    ElemType insert = 44;
//    ListInsert(&list, 5, insert);
//    //线性表的删除操作
//    ListDelete(&list, 5);
//    //线性表是否为空
//    ListisEmpty(list);
//    //线性表是否已满
//    ListisFull(list);
//    //元素是否存在
//    ElemisExitInList(list, 74);
//    //两个顺序线性表的合并
//    combineTwoLinkLists();
    //两个线性表的拼接
//    jointTwoLinkLists();
//    //线性表的拆分
//    componentLinkList();
}

/**
 初始化线性表
 */
SQList initSequentialList(int listLength)
{
    
    SQList list;
    list.length = 0;
//    listLength = (listLength >= MAXSIZE) ? MAXSIZE : listLength;
    RYQLog(@"listLength = %d", listLength);
    for (int i = 0; i < listLength; i++) {
        
        ElemType elem = rand() % 100 + 1;//100以内的随机数
        list.data[i] = elem;
        list.length++;
        
    }
//    list.listSize = MAXSIZE;
    list.listSize = listLength;
    RYQLog(@"list.length = %d   list.listSize %d", list.length, listLength);
    
    return list;
    
}

/**
 获得链表元素操作
 思路：
 1.线性表不能为空
 2.下标不能小于1
 3.下标i不能大于线性表长
 时间复杂度 O（1）

 @param list SQList
 @param i 下标
 @return 状态
 */
Status GetElem (SQList list, int i)
{
    if (list.length == 0 || i < 1 || i > list.length) {
        return ERROR;
    }
    ElemType elem = list.data[i - 1];
    
    RYQLog(@"获得链表元素操作   elem = %d ", elem);
    
    return SUCCESS;
}

/**
 线性表的插入操作
 思路：
 1.插入位置不合理，抛出异常。例如数组的长度为20，线性表的长度为10，插入的位置是15，显然不合规矩的，顺序线性链表中的元素是连续的。
 2.如果未向线性表中插入数据之前，线性表的长度等于数组长度（不可能大于），则抛出异常或动态增加容量
 3.从第i个位置遍历到最后一个元素，将这些元素都向后移动一个位置
 4.将要插入的元素放置到位置i处
 5.线性表长length加一
 时间复杂度 O（n）

 @param list SQList
 @param i 下标
 @param elem ElemType
 @return 状态
 */
Status ListInsert (SQList *list, int i , ElemType elem)
{
    int k;
    //线性表已填满  此处先暂时抛出异常
    if (list->length >= list->listSize) {
        return ERROR;
    }
    //插入位置不合理，抛出异常。
    if (i < 1 || i > list->length+1) {
        return ERROR;
    }
    //插入位置在表尾 不需要移动元素，在i(其他位置)，从第i个位置遍历到最后一个元素，将这些元素都向后移动一个位置
    if (i < list->length) {
        
        for (k = list->length-1 ; k > i - 1; k--) {
            list->data[k+1] = list->data[k];
        }
        
    }
    //新元素的赋值
    list->data[i-1] = elem;
    list->length ++;
//    //查询
//    GetElem(list, i);
    
    return SUCCESS;
}

/**
 为一个线性顺序表添加数据

 @param list SQList
 @param elem ElemType
 */
void addElemToList(SQList *list, ElemType elem)
{
    //线性表已填满  此处先暂时抛出异常
    if (list->length >= list->listSize) {
//        RYQLog(@"线性表已填满");
//        return;
        //线性表的l扩容
        sequentialListDilatation(list);
    }
    int length = list->length;
    RYQLog(@"%d", length);
    //新元素的赋值
    list->data[list->length] = elem;
    list->length ++;
    travelWholeList(*list);
}

/**
 线性表的删除操作
 思路:
 1.如果删除位置不合理，抛出异常。例如数组的长度为20，线性表的长度为10，删除的位置是15，显然不合规矩的，顺序线性链表中的元素是连续的。
 2.取出删除的元素
 3.从删除元素的位置开始遍历到最后一个元素结束，分别将他们都向前移动1个位置。
 4.线性表长length减一
 时间复杂度 O（n）

 @param list SQList
 @param i 下标
 @return 状态
 */
Status ListDelete (SQList *list, int i)
{
    int k;
    //线性表为空
    if (list->length == 0) {
        return ERROR;
    }
    //删除位置不正确
    if (i < 1 || i > list->length) {
        return ERROR;
    }
    //取出删除的元素
    ElemType elem = list->data[i-1];
    RYQLog(@"要删除的元素 elem = %d", elem);
    //删除的位置在表尾 不需要移动元素，在i(其他位置)，从第i个位置遍历到最后一个元素，将这些元素都向前移动一个位置
    if (i < list->length) {
        
        for (k = i; k < list->length; k++) {
            list->data[k-1] = list->data[k];
        }
        
    }
    list->length--;
    
    return SUCCESS;
}

/**
 线性表是否为空

 @param list 线性顺序存储表
 @return ERROR 不为空； SUCCESS 为空；
 */
Status ListisEmpty(SQList list)
{
    if (list.length == 0) {
        RYQLog(@"线性表为空");
        return SUCCESS;
    }
    RYQLog(@"线性表不为空");
    return ERROR;
}

/**
 线性表是否已满

 @param list 线性顺序存储表
 @return ERROR 线性表未满；SUCCESS 线性表已满
 */
Status ListisFull(SQList list)
{
    if (list.length >= list.listSize) {
        RYQLog(@"线性表已满");
        return SUCCESS;
    }
    RYQLog(@"线性表未满");
    return ERROR;
}

/**
 元素是否在线性顺序表中

 @param list 线性顺序存储表
 @param elem 元素
 @return ERROR 不存在；SUCCESS 存在
 */
Status ElemisExitInList(SQList list, ElemType elem)
{
    int index = -1;
    
    for (int i = 0; i < list.length; i++) {
        
        ElemType currentElem = list.data[i];
        if (currentElem == elem) {
            
            index = i;
            RYQLog(@"元素在线性顺序表中 他是第%d个元素", index+1);
            return SUCCESS;
        }
        
    }
    
    RYQLog(@"元素不存在线性顺序表中");
    
    return ERROR;
}

/**
 顺序线性表的扩容

 @param list 顺序线性表
 */
void sequentialListDilatation(SQList *list)
{
//    if(Psql->size=Psql->capacity)    //表满
//    {
//        Psql->capacity*=n;    //扩容成n倍
//        elemtype *new_data=(elemtype*)malloc(Psql->capacity*sizeof(elemtype));    //不建议用realloc函数
//        memcpy(new_data,Psql->data,Psql->size*sizeof(elemtype));    //从源src所指的内存地址的起始位置开始拷贝n个字节到目标dest所指的内存地址的起始位置中
//        free(Psql->data);
//        Psql->data=new_data;
//        printf("扩容成功\n");
//    }
    
    list->listSize *= 2;

    list->listSize = list->listSize+1;
}

/**
 遍历打印表中的所有元素

 @param list 线性表
 */
void travelWholeList(SQList list)
{
    for (int i = 0; i < list.length; i++) {
        
        RYQLog(@"第%d个元素  它的值为%d", i+1, list.data[i]);
        
    }
}

/**
 清空线性顺序表

 @param list 线性顺序表
 */
void cleanLinkList(SQList list)
{
    list.length = 0;
}

/**
 线性顺序表的销毁
 */
void destoryLinkList (SQList list)
{
    free(&list);
}

/**
 两个线性表的合并 A表和B表两个表合并后的新表里面，没有重复的元素。（A与B的并集）
 */
void combineTwoLinkLists ()
{
    SQList secondList = initSequentialList(5);
    SQList firstList = initSequentialList(10);
    int firstLength = firstList.length;
    int secondLength = secondList.length;
    //如果firstLength + secondLength > firstList.listSize 表示该线性表的数组的最大容量需要增大。
    if (firstLength + secondLength > firstList.listSize) {
        firstList.listSize = firstLength + secondLength;
    }
    //将secondList表中的元素 一个个插入到firstList表中
    for (int i = 0; i < secondLength; i++) {
        //从secondList表中将元素一个个取出来
        ElemType elem = secondList.data[i];
        //检测取出来的元素在firstList中是否存在
        Status type = ElemisExitInList(firstList, elem);
        //如果不存在 则将elem插入放到firstList表中
        if (type == ERROR) {
            addElemToList(&firstList, elem);
        }
    }
    RYQLog(@"两个线性表的合并   %d", firstList.length);
}

/**
 两个线性表的拼接 不考虑A表和B表中是否有重复的元素。直接将B表拼接在A表的后面
 */
void jointTwoLinkLists ()
{
    SQList secondList = initSequentialList(15);
    SQList firstList = initSequentialList(10);
    int firstLength = firstList.length;
    int secondLength = secondList.length;
    //如果firstLength + secondLength > firstList.listSize 表示该线性表的数组的最大容量需要增大。
    if (firstLength + secondLength > firstList.listSize) {
        firstList.listSize = firstLength + secondLength;
    }
    //将secondList表中的元素 一个个插入到firstList表中
    for (int i = 0; i < secondLength; i++) {
        //从secondList表中将元素一个个取出来
        ElemType elem = secondList.data[i];
        //则将elem插入放到firstList表中
        addElemToList(&firstList, elem);
    }
    RYQLog(@"两个线性表的拼接   %d", firstList.length);
}

/**
 线性表的拆分
 */
void componentLinkList ()
{
    //假设切割后listA长度为10，listB为5；
    int listA_Length = 10;
    int listB_length = 5;
    
    SQList list = initSequentialList(listA_Length+listB_length);
    SQList listB = initSequentialList(0);
    RYQLog(@"******** list.data[5] = %d", list.data[5]);
    for (int i = 0; i < listB_length; i++) {
        ElemType elem = list.data[i+listA_Length];
        //将list表的后五个元素分给listB
        addElemToList(&listB, elem);
        //将list表的后五个元素删除
        ListDelete(&list, list.length);
    }
    RYQLog(@"******** list.data[5] = %d", list.data[5]);
    RYQLog(@"%d    %d", list.length, listB.length);
}

/**
 通过以上总结发现顺序存储线性表的优缺点：
 优点：取出元素很容易。不用为表示表中元素之间的逻辑关系而增加额外的存储空间
 缺点：删除和插入要移动大量元素。删除的时候容易造成存储空间碎片。线性表的长度变化较大时，难以控制存储空间的容量.线性表的数组长度需要给定
 */

@end
