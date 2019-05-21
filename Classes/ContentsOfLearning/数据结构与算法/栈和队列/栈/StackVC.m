//
//  StackVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "StackVC.h"

@interface StackVC ()

@end

@implementation StackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //递归运算
    int num = YQNumber(30);
    RYQLog(@"%d", num);
    //迭代运算
    RYQLog(@"%d", forCycle(30));
}

/**
 递归运算  选择结构 递归能使程序的结构清晰，但是放大量的递归调用会建立函数的副本，耗费大量的时间和内存

 @param i num
 @return result
 */
int YQNumber (int i)
{
    if (i < 2) {
        return i == 0 ? 0 : 1;
    }
    
    return YQNumber(i-1) + YQNumber(i-2);
}

/**
 迭代运算 循环结构 不需要额外的内存
 */
int forCycle(int max)
{
    if (max < 2) {
        return 0;
    }
    
    int array[max];
    array[0] = 0;
    array[1] = 1;

    int sum = array[1];
    for (int i = 2; i <= max; i++) {
        
        array[i] = array[i-1] + array[i-2];
        sum = array[i];
    }
    
    return sum;
}


@end
