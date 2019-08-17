//
//  SequentialSearchVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/8/16.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 顺序查找表是针对一线性表进行查找操作，因此它是静态查找表。
 顺序查找又叫线性查找，是最基本的查找技术。它的查找过程是：从表中第一个或最后一个记录开始，逐个进行记录的关键字和给定值比较，若某个记录的关键字和给定值相等，则查找成功，找到所查的记录；如果知道最后一个或第一个记录，其关键字和给定值比较不相等的时候，则表中没有搜查的记录，查找不成功。
 */
#import "SequentialSearchVC.h"

#define MaxSize 100 //存储空间初始分配量

int Fib[MaxSize];//斐波那契数列

@interface SequentialSearchVC ()

@end

@implementation SequentialSearchVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    int list[MaxSize+1], i;
    int array[MaxSize] = {0, 1, 16, 24, 35, 47, 59, 62, 73, 88, 99};
    
    for (i = 0; i <= MaxSize; i++) {
        list[i] = i;
    }
    //无哨兵顺序查找
    WithOutSentrySequentialSearch(list, MaxSize, MaxSize*2);
    //有哨兵顺序查找
    SentrySequentialSearch(list, MaxSize, MaxSize/2);
}

/**
 无哨兵顺序查找

 @param list 数组
 @param n 要查找的数组的个数
 @param key 要查找的关键字
 */
void WithOutSentrySequentialSearch(int *list, int n, int key)
{
    int i;
    
    for (i = 1; i <= n; i++) {
        if (list[i] == key) {
            RYQLog(@"无哨兵顺序查找 ********** 搜查到查找的对象 key = %d", list[i]);
            return;
        }
    }
    RYQLog(@"无哨兵顺序查找 ********** 没有搜查到查找的对象");
}

/**
 有哨兵顺序查找

 @param list 数组
 @param n 要查找的数组的个数
 @param key 要查找的关键字
 */
void SentrySequentialSearch(int *list, int n, int key)
{
    int i;
    list[0] = key;
    i = n;
    while (list[i] != key) {
        i--;
    }
    if (i== 0) {
        RYQLog(@"有哨兵顺序查找 ********** 没有搜查到查找的对象");
    }else{
        RYQLog(@"有哨兵顺序查找 ********** 搜查到查找的对象 key = %d", list[i]);
    }
}

@end
