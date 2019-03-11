//
//  AutoreleasePoolVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/11.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "AutoreleasePoolVC.h"
/**
 autoreleasePool是一个延时release的机制， 在自动释放池被销毁或耗尽时，会向池中的所有对象发送release消息，释放所有autorelease对象。
 ARC下，我们使用@autoreleasepool{}来使用一个自动释放池
 
 AutoreleasePool并没有单独的结构，而是由若干个AutoreleasePoolPage作为结点以双向链表的形式组合而成。整个链表以堆栈的形式运作。
 1、每一个指针代表一个加入到释放池的对象 或者是哨兵对象，哨兵对象是在 @autoreleasepool{} 构建的时候插入的
 
 2、当自动释放池 pop的时候，所有哨兵对象之后的对象都会release
 
 3、链表会在一个Page空间占满时进行增加，一个AutoreleasePoolPage的空间被占满时，会新建一个AutoreleasePoolPage对象，连接链表，后来的autorelease对象在新的page加入。
 
 
 主线程：
 
 主线程runloop中注册了两个Observer，回调都是 _wrapRunLoopWithAutoreleasePoolHandler()。
 
 第一个oberver监听 当从休眠状态即将进入loop的时候 ，这个时候，构建自动释放池
 
 第二个oberver监听 当准备进入休眠状态的时候，调用 objc_autoreleasePoolPop() 和 _objc_autoreleasePoolPush() 释放旧的池并创建新池
 
 
 子线程：
 
 runloop默认不开启，不会自动创建自动释放池，在需要使用自动释放池的时候，需要我们手动创建、添加自动释放池，此时如果所有的异步代码都写在自动释放池中，也可以理解为当子线程销毁的时候，自动释放池释放
 
 Autorelease对象什么时候释放？
 
 这个问题拿来做面试题，问过很多人，没有几个能答对的。很多答案都是“当前作用域大括号结束时释放”，显然木有正确理解Autorelease机制。
 在没有手加Autorelease Pool的情况下，Autorelease对象是在当前的runloop迭代结束时释放的，而它能够释放的原因是系统在每个runloop迭代中都加入了自动释放池Push和Pop
 */

@interface AutoreleasePoolVC ()

@property (nonatomic, strong) NSString *name;

@end

@implementation AutoreleasePoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.name = @"自动释放池";
    @autoreleasepool {
        self.name = @"自动释放池";
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    @autoreleasepool {
//        self.name = nil;
//    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    RYQLog(@"%@", self.name);
}

- (void)dealloc {
    RYQLog(@"dealloc");
    RYQLog(@"%@", self.name);
}

@end
