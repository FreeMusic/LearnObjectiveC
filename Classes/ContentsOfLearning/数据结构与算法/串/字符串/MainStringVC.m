//
//  MainStringVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainStringVC.h"

@interface MainStringVC ()

@end

@implementation MainStringVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"串的定义与比较" vcName:@"StringVC"],
                      [ObjectiveModel initTitle:@"串的存储结构" vcName:@"StoreOfStringVC"],
                      [ObjectiveModel initTitle:@"KMP匹配模式算法" vcName:@"KMPMatchVC"],
                      ];
}


@end
