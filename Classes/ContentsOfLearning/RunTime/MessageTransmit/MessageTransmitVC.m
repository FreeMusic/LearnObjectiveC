//
//  MessageTransmitVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/12.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MessageTransmitVC.h"
#import "TransmitObject.h"


/**
 Runtime消息传递一个对象的方法  [obj test]，编译器转成消息发送objc_msgSend(obj, test)，Runtime时执行的流程是这样的：
 1.首先，通过obj的isa指针找到它的class;
 2.在class的method list找test;
 3.如果class中没到test，继续往它的superclass中找 ;
 4.一旦找到test这个函数，就去执行它的实现IMP
 当然了，由于效率的问题，每个消息都遍历一次objc_method_list并不合理。所以需要把经常被调用的函数缓存下来，去提高函数查询的效率。这也就是objc_class中另一个重要成员objc_cache做的事情 - 再找到test之后，把test的method_name作为key，method_imp作为value给存起来。当再次收到test消息的时候，可以直接在cache里找到，避免去遍历objc_method_list。从前面的源代码可以看到objc_cache是存在objc_class结构体中的。
 */

@interface MessageTransmitVC ()

@end

@implementation MessageTransmitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TransmitObject *obj = [[TransmitObject alloc] init];
    SEL selector = NSSelectorFromString(@"eat");
    [obj performSelector:selector];
}

- (void)eat{
    
}

@end
