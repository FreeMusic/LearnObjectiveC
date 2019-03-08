//
//  KVO_AimModel.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/8.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVO_AimModel : NSObject

@property (nonatomic, assign) int age;

@property (nonatomic, copy) NSString *name;

@end


///**
// 自定义实现KVO
// */
//
//@interface NSObject (RYQKVO)
//
//- (void)ryq_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
//
//@end
