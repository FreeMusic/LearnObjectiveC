//
//  KVO_VC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "KVO_VC.h"
#import "KVO_AimModel.h"

/**
 1.KVO是基于runtime机制实现的
 
 2.当某个类的属性对象第一次被观察时，系统就会在运行期动态地创建该类的一个派生类，在这个派生类中重写基类中任何被观察属性的setter 方法。派生类在被重写的setter方法内实现真正的通知机制
 
 3.如果原类为Person，那么生成的派生类名为NSKVONotifying_Person
 
 4.每个类对象中都有一个isa指针指向当前类，当一个类对象的第一次被观察，那么系统会偷偷将isa指针指向动态生成的派生类，从而在给被监控属性赋值时执行的是派生类的setter方法
 
 5.键值观察通知依赖于NSObject 的两个方法: willChangeValueForKey: 和 didChangevlueForKey:；在一个被观察属性发生改变之前， willChangeValueForKey:一定会被调用，这就 会记录旧的值。而当改变发生后，didChangeValueForKey:会被调用，继而 observeValueForKey:ofObject:change:context: 也会被调用。
 */

@interface KVO_VC ()

@end

@implementation KVO_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KVO_AimModel *aim = [KVO_AimModel new];
    aim.age = 13;
    
    //添加观察者
    [aim addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    aim.age = 18;
    aim.age = 22;
    aim.age = 56;
}

/**
 所观察的对象的keyPath 发生改变的时候, 会触发
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    RYQLog(@"%@", keyPath);
    RYQLog(@"%@", change);
    
}

@end
