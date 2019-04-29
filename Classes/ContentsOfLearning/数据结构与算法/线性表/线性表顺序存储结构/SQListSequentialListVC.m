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

typedef int ElemType;//int类型的数据

typedef struct {
    
    ElemType data[MAXSIZE];//数组存储数据元素 最大值为MAXSIZE 数组data，r它的存储位置就是存储空间的存储位置
    int length; //线性表当前长度
    struct SQList *next;
    
}SQList;

typedef NS_ENUM(NSUInteger, Status) {
    
    ERROR = 0,//失败或者报错
    SUCCESS = 1,//成功
    
};

@interface SQListSequentialListVC ()

@end

@implementation SQListSequentialListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
 @param elem ElemType
 @return 状态
 */
Status GetElem (SQList list, int i , ElemType elem)
{
    if (list.length == 0 || i < 1 || i > list.length) {
        return ERROR;
    }
    elem = list.data[i - 1];
    
    
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
Status ListInsert (SQList list, int i , ElemType elem)
{
    int k;
    //线性表已填满  此处先暂时抛出异常
    if (list.length == MAXSIZE) {
        return ERROR;
    }
    //插入位置不合理，抛出异常。
    if (i < 1 || i > list.length+1) {
        return ERROR;
    }
    //插入位置在表尾 不需要移动元素，在i(其他位置)，从第i个位置遍历到最后一个元素，将这些元素都向后移动一个位置
    if (i < list.length) {
        
        for (k = list.length-1 ; k > i - 1; k--) {
            list.data[k+1] = list.data[k];
        }
        
    }
    //新元素的赋值
    list.data[i-1] = elem;
    list.length ++;
    
    return SUCCESS;
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
 @param elem ElemType
 @return 状态
 */
Status ListDelete (SQList list, int i, ElemType elem)
{
    int k;
    //线性表为空
    if (list.length == 0) {
        return ERROR;
    }
    //删除位置不正确
    if (i < 1 || i > list.length) {
        return ERROR;
    }
    //取出删除的元素
    elem = list.data[i-1];
    //删除的位置在表尾 不需要移动元素，在i(其他位置)，从第i个位置遍历到最后一个元素，将这些元素都向前移动一个位置
    if (i < list.length) {
        
        for (k = i; k < list.length; k++) {
            list.data[k-1] = list.data[k];
        }
        
    }
    list.length--;
    
    return SUCCESS;
}

/**
 通过以上总结发现顺序存储线性表的优缺点：
 优点：取出元素很容易。不用为表示表中元素之间的逻辑关系而增加额外的存储空间
 缺点：删除和插入要移动大量元素。删除的时候容易造成存储空间碎片。线性表的长度变化较大时，难以控制存储空间的容量.线性表的数组长度需要给定
 */

@end
