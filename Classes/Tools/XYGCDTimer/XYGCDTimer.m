//
//  XYGCDTimer.m
//  TanWinSAAS
//
//  Created by 乐逍遥 on 2020/8/5.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "XYGCDTimer.h"

@interface XYGCDTimer ()

@property(nonatomic,strong) dispatch_source_t timer;

@end

@implementation XYGCDTimer

+ (instancetype)shareTimer {
  static XYGCDTimer *countDown = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (countDown == nil) {
      countDown = [[XYGCDTimer alloc]init];
    }
  });
  
  return countDown;
}

-(instancetype)init{
  self = [super init];
  if (self) {
    
  }
  return self;
}

/// 定时器 间隔一定时间执行某个方法
/// @param timeInterVal 时间间隔
/// @param circleBlock block回调
- (void)startTimerWithTimeInterVal:(int)timeInterVal circleBlock:(XYGCDCircleTimerBlock)circleBlock {
  //移除上一个定时器
  [self removeTimer];
  
  dispatch_queue_t queue = dispatch_get_main_queue();
  //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
  self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  
  //设置定时器的各种属性
  dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
  uint64_t interval = (uint64_t)(timeInterVal*NSEC_PER_SEC);
  dispatch_source_set_timer(self.timer, start, interval, 0);
  
  
  //设置回调
  dispatch_source_set_event_handler(self.timer, ^{
    //定时器需要执行的操作
    if (circleBlock) {
      circleBlock();
    }
  });
  //启动定时器（默认是暂停）
  dispatch_resume(self.timer);
}

/// 定时器 在定时器倒计时结束时 执行某个方法
/// @param timeInterVal 定时器倒计时结束时长
/// @param circleBlock 执行某个方法
- (void)timerCutDownFinishedWithTimeInterVal:(int)timeInterVal circleBlock:(XYGCDCircleTimerBlock)circleBlock {
  ///定时器倒计时结束时长为0 直接return
  if (timeInterVal == 0) {
    if (circleBlock) {
      circleBlock();
    }
    return;
  }
  if (_timer) {
    return;
  }
  __block NSInteger second = timeInterVal;
  //全局队列    默认优先级
  dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  //定时器模式  事件源
  dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
  
  _timer = timer;
  
  //NSEC_PER_SEC是秒，＊1是每秒
  dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), NSEC_PER_SEC * 1, 0);
  //设置响应dispatch源事件的block，在dispatch源指定的队列上运行
  dispatch_source_set_event_handler(timer, ^{
      //回调主线程，在主线程中操作UI
      dispatch_async(dispatch_get_main_queue(), ^{
          if (second >= 0) {
              second--;
          }else{
              //时间已到 移除定时器
            [self removeTimer];
            //回调
            if (circleBlock) {
              circleBlock();
            }
          }
      });
  });
  //启动源
  dispatch_resume(timer);
}

/// 销毁移除定时器
- (void)removeTimer{
  if (self.timer) {
    dispatch_cancel(self.timer);
    self.timer = nil;
  }
}

@end
