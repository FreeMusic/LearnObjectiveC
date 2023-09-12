//
//  MainStructureVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/8.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainStructureVC.h"

#define MAXSIZE 20

typedef int ElemType;

struct Node {
    ElemType data;
    struct Node *next;
};

typedef NS_ENUM(int ,Status) {
    StatusError,
    StatusSuccess,
    StatusUnKnown,
};

typedef struct Node *LinkList;

@interface MainStructureVC ()

@end

@implementation MainStructureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"算法的时间复杂度" vcName:@"TimeComplexityVC"],
                      [ObjectiveModel initTitle:@"线性表" vcName:@"MainLinearTableVC"],
                      [ObjectiveModel initTitle:@"栈和队列" vcName:@"MainStackTempVC"],
                      [ObjectiveModel initTitle:@"字符串" vcName:@"MainStringVC"],
                      [ObjectiveModel initTitle:@"树🌲" vcName:@"MainTreeVC"],
                      [ObjectiveModel initTitle:@"图🤮" vcName:@"MainGraphVC"],
                      [ObjectiveModel initTitle:@"查找🔍" vcName:@"MainSearchVC"],
                      [ObjectiveModel initTitle:@"LeeCode" vcName:@"LeeCodeMainlistVC"],
                      ];
    XYLog(@"MainStructureVC 执行了viewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    XYLog(@"MainStructureVC 执行了viewWillAppear");
}

@end
