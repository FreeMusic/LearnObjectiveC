//
//  FundationPlayVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/9/12.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "FundationPlayVC.h"

@interface FundationPlayVC ()

@end

@implementation FundationPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
        [ObjectiveModel initTitle:@"AffineTransform变换" vcName:@"AffineTransformVC"],
    ];
}


@end
