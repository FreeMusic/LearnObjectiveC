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

#define MaxSize 40 //存储空间初始分配量

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
    //折半查找
    BinarySearch(array, 10, 62);
    //插值查找
    InterPloationSearch(array, MaxSize, MaxSize/2);
    //构造斐波那契数列
    structureFib();
    //斐波那契查找
    FibonacciSearch(array, MaxSize, MaxSize/2);
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
/**
 折半查找：折半查找技术又称二分查找。它的前提是线性表中的记录必须是关键码有序(通常从小到大有序)，线性表必须采用顺序存储。折半查找的基本思想是：在有序表中，取中间记录作为比较对象，若给定值与中间记录的关键字相等，则查找成功；若给定值小于中间记录的关键字，则在中间记录的左半区继续查找；若给定值大于中间记录的关键字，则在中间记录的右半区继续查找。不断重复上述过程，知道查找成功，或所有查找区域无记录，查找失败为止。
 
 @param list 数组
 @param n 要查找的数组的个数
 @param key 要查找的关键字
 */
void BinarySearch(int *list, int n, int key)
{
    int low, high, mid;
    low = 1;//定义最低下标为记录首位
    high = n;//定义最高下标为记录首位
    while (low <= high) {
        //开启折半查找
        mid = (low+high)/2;//折半
        if (key < list[mid]) {
            //若查找值比中值小
            high = mid - 1;//最高下标调整到中位下标小一位
        }else if(key > list[mid]){//若查找值比中值大
            low = mid+1;//最低下标调整到中位下标大一位
        }else{
            //若相等则说明mid即为查找到的位置
            RYQLog(@"折半查找 ********** 找到的位置为mid = %d", mid);
            return;
        }
    }
    RYQLog(@"折半查找 ********** 没有找到key所在的位置");
}
/**
 插值查找
 
 @param list 数组
 @param n 要查找的数组的个数
 @param key 要查找的关键字
 */
void InterPloationSearch(int *list, int n, int key)
{
    int low, high, mid;//
    low = 1;//定义最低下标为记录首位
    high = n;//定义最高下标为记录首位
    
    while (low < high) {
        mid = low+(high-low)*(key-list[low])/(list[high]-list[low]);//插值
        if (key < list[mid]) {//若查找值比插值小
            high = mid-1;//最高下标调整到插值下标小一位
        }else if (key > list[mid]){//若查找值比插值大
            low = mid+1;//最低下标调整到插值下标大一位
        }else{
            //若相等则说明mid即为查找到的位置
            RYQLog(@"插值查找 ********** 找到的位置为mid = %d", mid);
            return;
        }
    }
    RYQLog(@"插值查找 ********** 没有找到key所在的位置");
}

/**
 构造斐波那契数列
 */
void structureFib()
{
    Fib[0]=0;
    Fib[1]=1;
    for(int i = 2;i < MaxSize;i++)
    {
        Fib[i] = Fib[i-1] + Fib[i-2];
    }
}

/**
 斐波那契查找

 @param list 数组
 @param n 要查找的数组的个数
 @param key 要查找的关键字
 */
void FibonacciSearch(int *list, int n, int key)
{
    int low, high, mid, i, k = 0;
    low = 1;//定义最低下标为记录首位
    high = n;//定义最高下标为记录末位
    while (n > Fib[k]-1) {
        k++;
    }

    for (i = n; i < Fib[k]-1; i++) {
        list[i] = list[n];
    }

    while (low <= high) {
        mid = low+Fib[k-1]-1;
        if (key < list[mid]) {
            high = mid-1;
            k = k - 1;
        }else if (key > list[mid]){
            low = mid+1;
            k = k-2;
        }else{

            if (mid <= n) {
                //若相等则说明mid即为查找到的位置
                RYQLog(@"斐波那契查找 ********** 找到的位置为mid = %d", mid);
                return;
            }else{
                RYQLog(@"斐波那契查找 ********** 找到的位置为n = %d", n);
                return;
            }
        }
    }

    RYQLog(@"斐波那契查找 ********** 没有找到key所在的位置");
}

@end
