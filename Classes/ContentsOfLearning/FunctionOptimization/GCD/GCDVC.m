//
//  GCDVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/24.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "GCDVC.h"

@interface GCDVC ()



@end


@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 异步函数下的主队列
    [self asyncMainThread];
    //异步函数并发队列
    [self asyncConcurrentThread];
}


/// 异步函数下的主队列
- (void)asyncMainThread{
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        sleep(1);
        RYQLog(@"异步函数下的主队列   任务1  %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        RYQLog(@"异步函数下的主队列   任务2  %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        RYQLog(@"异步函数下的主队列   任务3  %@", [NSThread currentThread]);
    });
}

/// 异步函数并发队列
- (void)asyncConcurrentThread{
    
    dispatch_queue_t queue = dispatch_queue_create("asyncConcurrentThread", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        sleep(1);
        RYQLog(@"异步函数并发队列   任务1  %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        RYQLog(@"异步函数并发队列   任务2  %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        RYQLog(@"异步函数并发队列   任务3  %@", [NSThread currentThread]);
    });
    
}

@end
