//
//  TimeComplexityVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/9.
//  Copyright © 2019 橘子. All rights reserved.
//

//算法时间复杂度的定义：
//在进行算法分析时，语句的总的执行次数T(n)是关于问题规模n的函数，进而分析T(n)随n的变化情况并确定T(n)的数量级。算法的时间复杂度，也就是算法的时间量度，记做：T(n)=O(f(n)).它表示随问题规模n的增大，算法执行时间的增长率和f(n)的增长率相同，称作算法的渐近时间复杂度，简称为时间复杂度。其中f(n)的问题规模n的某个函数。
//这样用O()来体现算法时间复杂度的记法，称为大O记法。
//一般情况下，随着n的增大，T(n)增长最慢的算法为最优算法
/*
 推导大O阶的规则：
 1.用常数1取代运行时间中的所有加法常数。
 2.在修改后的运行次数函数中，只保留最高阶项。
 3.如果最高阶项存在且不是1，则去除与这个项相乘的常数
 如此得到的结果就是大O阶
 */

#import "TimeComplexityVC.h"

@interface TimeComplexityVC ()

@end

@implementation TimeComplexityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*常数阶*/
    constantOfTheOrder();
    /*线型阶*/
    linearOrder();
    /*对数阶*/
    theLogarithmicOrde();
    /*平方阶*/
    squareOrder();
}

/**
 常数阶 计算1到100的累加
 */
void constantOfTheOrder(){
    
    /*执行一次*/
    int sum = 0, n = 100;
    /*执行一次*/
    sum = (1+n)*n/2;
    /*执行一次*/
    RYQLog(@"%d", sum);
    
    /*该算法的运行次数函数是f(n)=3,运用推导大O阶的规则，第一步把常数3改为1，又因为没有最高阶。所以该算法的时间复杂度可表示为：O(1)*/
    
}

/**
 线型阶
 */
void linearOrder() {
    
    /*这里可以理解为n是一个变量，可为1000，或者无穷大*/
    /*执行一次*/
    int n = 10;
    /*执行一次*/
    int sum = 0;
    /*执行一次*/
    int product = 1;
    
    for (int i = 0; i < n; i++) {
        
        /*执行一次*/
        sum = sum + i;
        /*执行一次*/
        product = product * (i + 1);
        
    }
    
    /*该算法的运行次数函数是f(n)=2n+3,运用推导大O阶的规则，第一步把常数3改为1，只保留最高阶，即f(n) = 2n,在去除最高阶相乘的常数2，可以得到该算法的时间复杂度可表示为：O(n)*/
}

/**
 对数阶
 */
void theLogarithmicOrde(){
    
    /*这里可以理解为n是一个变量，可为1000，或者无穷大*/
    /*执行一次*/
    int n = 10;
    /*执行一次*/
    int count = 3;
    
    while (count < n) {
        
        /*执行一次*/
        count = count*2;
        
    }
    /*由于每次count 乘以2之后，就距离n更近了一分。也就是说，有多少个2相乘后大于 n ，则会退出循环。由于 2^x = n 得到 x = log2(n) 所以这个循环的时间复杂度为O(logn)。*/
    
}

/**
 平方阶
 */
void squareOrder(){
    
    int i, j, sum;
    int n = 100;
    
    for (i = 0; i < n; i++) {
        
        for (j = i; j < n; j++) {
            /*执行一次*/
            sum = i + j;
            
        }
        
    }
    /*i = 0, sum = i + j;执行了n次；
     i=1,执行了n-1次
     n+(n-1)+...+1 = n(n+1)/2;
     f(n) = n(n+1)/2;
     可以得到该算法的时间复杂度可表示为：O(n2)
     */
    
}

@end
