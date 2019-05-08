//
//  MainLinearTableVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/9.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainLinearTableVC.h"

@interface MainLinearTableVC ()

@end

@implementation MainLinearTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"线性表的定义" vcName:@"DefineLinearTableVC"],
                      [ObjectiveModel initTitle:@"线性表的顺序存储结构" vcName:@"SQListSequentialListVC"],
                      [ObjectiveModel initTitle:@"单链表" vcName:@"SQListLinkedStorageVC"],
                      [ObjectiveModel initTitle:@"单向循环链表" vcName:@"CircularLinkedListVC"],
                      [ObjectiveModel initTitle:@"双向链表" vcName:@"BothWayLinkListVC"],
                      ];
}



@end
