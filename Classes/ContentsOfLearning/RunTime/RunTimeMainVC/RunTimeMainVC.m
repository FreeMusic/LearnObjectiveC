//
//  RunTimeMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//
/**
 
 OC语言的动态性主要体现在三个方面：动态类型(Dynamic typing)、动态绑定(Dynamic binding)和动态加载(Dynamic loading)。
 
 动态类型指的是对象指针类型的动态性，具体是指使用id任意类型将对象的类型确定推迟到运行时，由赋给它的对象类型决定对象指针的类型。另外类型确定推迟到运行时之后，可以通过NSObject的isKindOfClass方法动态判断对象最后的类型（动态类型识别）。也就是说id修饰的对象为动态类型对象，其他在编译器指明类型的为静态类型对象，通常如果不需要涉及到多态的话还是要尽量使用静态类型（原因上面已经说到：错误可以在编译器提前查出，可读性好）。
 
 动态绑定指的是方法确定的动态性，具体指的是利用OC的消息传递机制将要执行的方法的确定推迟到运行时，可以动态添加方法。也就是说，一个OC对象是否调用某个方法不是由编译器决定的，而是由运行时决定的；另外关于动态绑定的关键一点是基于消息传递机制的消息转发机制，主要处理应对一些接受者无法处理的消息，此时有机会将消息转发给其他接收者处理，具体见下面介绍。
 
 我们所说的Objective-C是动态运行时语言是什么意思？
 
 主要指的是OC语言的动态性，包括动态性和多态性两个方面。
 
 动态性：即OC的动态类型、动态绑定和动态加载特性，将对象类型的确定、方法调用的确定、代码和资源的装载等推迟到运行时进行，更加灵活；
 多态：多态是面向对象变成语言的特性，OC作为一门面向对象的语言，自然具备这种多态性，多态性指的是来自不同类的对象可以接受同一消息的能力，或者说不同对象以自己的方式响应相同的消息的能力。
 */
#import "RunTimeMainVC.h"

@interface RunTimeMainVC ()

@end

@implementation RunTimeMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"KVC" vcName:@"KVC_VC"],
                      [ObjectiveModel initTitle:@"KVO" vcName:@"KVO_VC"],
                      [ObjectiveModel initTitle:@"消息转发" vcName:@"MessageTransmitVC"],
                      [ObjectiveModel initTitle:@"防止数组越界" vcName:@"ArrayBoundsVC"],
                      [ObjectiveModel initTitle:@"消息转发整理" vcName:@"MessageFirstVC"],
                      ];
}

- (void)dealloc {
    
    RYQLog(@"dealloc");
    
}


@end
