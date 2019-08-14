//
//  MainSearchVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/8/14.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainSearchVC.h"

@interface MainSearchVC ()

@end

@implementation MainSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"查找概论🔍" vcName:@"SearchTableVC"],
                      ];
}

@end
