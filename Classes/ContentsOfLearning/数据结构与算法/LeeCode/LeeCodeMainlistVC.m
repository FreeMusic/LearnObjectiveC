//
//  LeeCodeMainlistVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/9/28.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "LeeCodeMainlistVC.h"

@interface LeeCodeMainlistVC ()

@end

@implementation LeeCodeMainlistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
        [ObjectiveModel initTitle:@"LeeCode 1~10 题" vcName:@"TenNumsAheadVC"],
    ];
}


@end
