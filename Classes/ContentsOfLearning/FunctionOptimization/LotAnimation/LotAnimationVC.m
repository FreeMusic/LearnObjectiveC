//
//  LotAnimationVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/11/19.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "LotAnimationVC.h"
#import "LOTAnimationView.h"

@interface LotAnimationVC ()

@end

@implementation LotAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath_= [[NSBundle mainBundle] pathForResource:@"bybike" ofType:@"json"];
    
    LOTAnimationView *animation = [LOTAnimationView animationWithFilePath:filePath_];
    animation.loopAnimation = YES;
    animation.frame = CGRectMake((kScreenWidth-300)/2, NavigationBarHeight*2, 50, 50);
    [self.view addSubview:animation];
    [animation play];
    animation.transform = CGAffineTransformMakeRotation(-M_PI*0.15);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animationTouch)];
    [animation addGestureRecognizer:tap];
}

- (void)animationTouch {
    RYQLog(@"animationTouch");
}

@end
