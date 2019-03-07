//
//  BAD_ACCESS_VC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

/**
 90%的错误来源在于对一个已经释放的对象进行release操作, 或者说对一个访问不到的地址进行访问，可能是由于些变量已经被回收了，亦可能是由于使用栈内存的基本类型的数据赋值给了id类型的变量。
 */

#import "BAD_ACCESS_VC.h"

@interface BAD_ACCESS_VC ()

@end

@implementation BAD_ACCESS_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = [self returnInt];
    RYQLog(@"%d", a);
    id badObjc = [self performSelector:@selector(returnInt)];
    RYQLog(@"%@", badObjc);

}
/**
 上面通过id去接受int返回值，int是存放在栈里面的，堆内存地址如何找得到，自然就是 EXC_BAD_ACCESS。
 */
- (int)returnInt {
    return 10;
}

@end
