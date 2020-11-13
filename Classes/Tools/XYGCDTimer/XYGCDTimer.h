//
//  XYGCDTimer.h
//  TanWinSAAS
//
//  Created by 乐逍遥 on 2020/8/5.
//  Copyright © 2020 Facebook. All rights reserved.
//  GCD定时器

#import <Foundation/Foundation.h>

typedef void(^XYGCDCircleTimerBlock)(void);//间隔时间执行某部分函数

NS_ASSUME_NONNULL_BEGIN

@interface XYGCDTimer : NSObject

/// 单例
+ (instancetype)shareTimer;

/// 定时器 间隔一定时间执行某个方法
/// @param timeInterVal 时间间隔
/// @param circleBlock block回调
- (void)startTimerWithTimeInterVal:(int)timeInterVal circleBlock:(XYGCDCircleTimerBlock)circleBlock;

/// 定时器 在定时器倒计时结束时 执行某个方法
/// @param timeInterVal 定时器倒计时结束时长
/// @param circleBlock 执行某个方法
- (void)timerCutDownFinishedWithTimeInterVal:(int)timeInterVal circleBlock:(XYGCDCircleTimerBlock)circleBlock;

/// 销毁移除定时器
- (void)removeTimer;

@end

NS_ASSUME_NONNULL_END
