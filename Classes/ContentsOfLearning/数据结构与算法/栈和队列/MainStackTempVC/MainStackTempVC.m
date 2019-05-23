//
//  MainStackTempVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainStackTempVC.h"

@interface MainStackTempVC ()

@end

@implementation MainStackTempVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"栈" vcName:@"StackVC"],
                      [ObjectiveModel initTitle:@"队列" vcName:@"QueueVC"],
                      ];
}



@end
