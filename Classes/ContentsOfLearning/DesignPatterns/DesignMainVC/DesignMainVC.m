//
//  DesignMainVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/11.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "DesignMainVC.h"
#import <GameKit/GameKit.h>

@interface DesignMainVC ()

@end

@implementation DesignMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"工厂设计模式" vcName:@"FactoryDesignVC"],
                      [ObjectiveModel initTitle:@"MVC设计模式" vcName:@"MVCController"],
                      ];
}


@end
