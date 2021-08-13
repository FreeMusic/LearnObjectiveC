//
//  MessageFirstVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/8/11.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "MessageFirstVC.h"
#import "MessageFirstObject.h"

@interface MessageFirstVC ()

@end

@implementation MessageFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 消息转发的第一阶段
    [self messageFirstStep];
}


/// 消息转发的第一阶段
- (void)messageFirstStep {
    MessageFirstObject *message = [[MessageFirstObject alloc] init];
    [message performSelector:@selector(playMessage)];
    [message methodInstacePlay];
    [MessageFirstObject methodClassPlay];
    [MessageFirstObject performSelector:@selector(classPlayMessage)];
}


@end
