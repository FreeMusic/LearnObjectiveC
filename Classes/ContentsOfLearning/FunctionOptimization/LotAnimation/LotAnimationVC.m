//
//  LotAnimationVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/11/19.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "LotAnimationVC.h"
#import "LOTAnimationView.h"
#import "XYGCDTimer.h"

static double timeInterval = 1;

@interface LotAnimationVC ()

@property (nonatomic, copy) NSString *elemTitle;///
@property (nonatomic, strong) LOTAnimationView *animation;///

@end

@implementation LotAnimationVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath_= [[NSBundle mainBundle] pathForResource:@"liveing" ofType:@"json"];
    
    self.animation = [LOTAnimationView animationWithFilePath:filePath_];
    self.animation.loopAnimation = YES;
    self.animation.frame = CGRectMake(0, NavigationBarHeight*2, 50, 50);
    [self.view addSubview:self.animation];
    [self.animation play];
//    animation.transform = CGAffineTransformMakeRotation(-M_PI*0.15);
    
//    LOTAnimationView *newView = self.animation;
//    [[XYGCDTimer shareTimer] startTimerWithTimeInterVal:timeInterval*2 circleBlock:^{
//        XYLog(@"动画");
//        [UIView animateWithDuration:timeInterval animations:^{
//            newView.frame = CGRectMake(kScreenWidth-50, NavigationBarHeight*2, 50, 50);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:timeInterval animations:^{
//                newView.frame = CGRectMake(0, NavigationBarHeight*2, 50, 50);
//            }];
//        }];
//    }];
}

- (void)startRepeatAnimation:(LOTAnimationView *)animation {
    
    [UIView animateWithDuration:timeInterval animations:^{
        animation.frame = CGRectMake(kScreenWidth-50, NavigationBarHeight*2, 50, 50);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:timeInterval animations:^{
            animation.frame = CGRectMake(0, NavigationBarHeight*2, 50, 50);
        }];
    }];
    
}

- (void)repeatAgainWithAnimation {
    XYLog(@"动画");
}

- (void)animationTouch {
    XYLog(@"animationTouch");
}

- (void)dealloc {
    XYLog(@"移除");
    [[XYGCDTimer shareTimer] removeTimer];
}

@end
