//
//  RunLoopMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "RunLoopMainVC.h"

typedef NS_ENUM(NSUInteger ,EventLoopMode) {
    EventLoopStartMode,
    EventLoopStopMode
};

@interface RunLoopMainVC ()

@property (nonatomic, assign) EventLoopMode mode;

@end

@implementation RunLoopMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //模拟EventLoop
//    [self simulateRunLoop:EventLoopStartMode];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self simulateRunLoop:EventLoopStopMode];
//    });
//    [[NSRunLoop currentRunLoop] run];
}

- (void)simulateRunLoop:(EventLoopMode)mode
{
    self.mode = mode;
    do {
        RYQLog(@"RunLoop一直在执行着");
    } while (self.mode == EventLoopStartMode);
}


@end
