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
                      ];
}


@end
