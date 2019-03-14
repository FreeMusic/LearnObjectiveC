//
//  MVCController.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/14.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MVCController.h"
#import "MVC_View.h"
#import "MVC_Model.h"

@interface MVCController ()

@end

@implementation MVCController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MVC_View *view = [[MVC_View alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    MVC_Model *model = [[MVC_Model alloc] init];
    model.title = @"MVC";
    view.model = model;
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}


@end
