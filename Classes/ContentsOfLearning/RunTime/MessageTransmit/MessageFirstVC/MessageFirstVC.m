//
//  MessageFirstVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/8/11.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "MessageFirstVC.h"
#import "MessageFirstObject.h"
#import "MessageSecondObject.h"

@interface MessageFirstVC ()

@end

@implementation MessageFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    /// 消息转发的第一阶段
//    [self messageFirstStep];
    /// 消息转发的第二阶段
    [self messageSecondStep];
}


/// 消息转发的第一阶段
- (void)messageFirstStep {
    MessageFirstObject *message = [[MessageFirstObject alloc] init];
    [message performSelector:@selector(playMessage)];
    [message methodInstacePlay];
    [MessageFirstObject methodClassPlay];
    [MessageFirstObject performSelector:@selector(classPlayMessage)];
}


/// 消息转发的第二阶段
- (void)messageSecondStep {
    MessageSecondObject *message = [[MessageSecondObject alloc] init];
    [message playObject];
    
    [message otherPlay];
    
    [message mixPlay];
}


@end
