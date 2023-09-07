//
//  UIKitPlayVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/3.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "UIKitPlayVC.h"

@interface UIKitPlayVC ()

@end

@implementation UIKitPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Messages = @[
        [ObjectiveModel initTitle:@"UIView动画" vcName:@"UIViewAnimationVC"],
        [ObjectiveModel initTitle:@"UICollectionView转场动画" vcName:@"UICollectionViewAnimationVC"],
        [ObjectiveModel initTitle:@"选择PDF文件" vcName:@"UIPDFSelectVC"],
    ];
}


@end
