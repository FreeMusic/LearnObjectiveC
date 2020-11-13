//
//  BallFibrillationVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/13.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "BallFibrillationVC.h"
#import "AimationBall.h"

static CGFloat ballWidth = 20;
static CGFloat animationTime = 1;

@interface BallFibrillationVC ()

{
    CGFloat backViewWidth;
}

@property (nonatomic, strong) UIView *backView;///

@end

@implementation BallFibrillationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    backViewWidth = kScreenWidth - 20;
    
    /// 背景
    [self initBackView];
    /// 球动画
    [self ballAnimation];
}

/// 背景
- (void)initBackView {
    self.backView = [[UIView alloc] init];
    [self.view addSubview:self.backView];
    self.backView.frame = CGRectMake(10, (kScreenHeight-backViewWidth)/2, backViewWidth, backViewWidth);
    self.backView.layer.cornerRadius = backViewWidth/2;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.borderWidth = 1;
    self.backView.layer.borderColor = BLACK_COLOR.CGColor;
}

/// 球动画
- (void)ballAnimation {
    //水平 左
    AimationBall *levelLeftBall = [self getBallWithOriginalFrame:CGRectMake(0, (backViewWidth-ballWidth)/2, ballWidth, ballWidth)
                                                    endFrame: CGRectMake(self.backView.lz_width-ballWidth, (self->backViewWidth-ballWidth)/2, ballWidth, ballWidth)];
    //水平 右
    AimationBall *levelRightBall = [self getBallWithOriginalFrame:CGRectMake(self.backView.lz_width-ballWidth, (self->backViewWidth-ballWidth)/2, ballWidth, ballWidth)
                                                    endFrame: CGRectMake(0, (backViewWidth-ballWidth)/2, ballWidth, ballWidth)];
    //竖直 顶部
    AimationBall *verticalTopBall = [self getBallWithOriginalFrame:CGRectMake((backViewWidth-ballWidth)/2, 0, ballWidth, ballWidth)
                                                          endFrame:CGRectMake((self->backViewWidth-ballWidth)/2, self.backView.lz_width-ballWidth, ballWidth, ballWidth)];
    CGFloat sqrtLength = sqrt(2)*(backViewWidth-ballWidth)/4;
    CGFloat reverseSqrtLength = (backViewWidth-ballWidth)/2-sqrtLength;
    //西北角45°
    AimationBall *topLeftBall = [self getBallWithOriginalFrame:CGRectMake(reverseSqrtLength, reverseSqrtLength, ballWidth, ballWidth)
                                                      endFrame:CGRectMake(((backViewWidth-ballWidth)-reverseSqrtLength), ((backViewWidth-ballWidth)-reverseSqrtLength), ballWidth, ballWidth)];
    //竖直 底部
    AimationBall *verticalBottomBall = [self getBallWithOriginalFrame:CGRectMake((self->backViewWidth-ballWidth)/2, self.backView.lz_width-ballWidth, ballWidth, ballWidth)
                                                             endFrame:CGRectMake((backViewWidth-ballWidth)/2, 0, ballWidth, ballWidth)];
    
    //西南角45°
    AimationBall *bottomLeftBall = [self getBallWithOriginalFrame:CGRectMake(reverseSqrtLength, ((backViewWidth-ballWidth)-reverseSqrtLength), ballWidth, ballWidth)
    endFrame:CGRectMake(((backViewWidth-ballWidth)-reverseSqrtLength), reverseSqrtLength, ballWidth, ballWidth)];
    
    //东北角
    AimationBall *topRightBall = [self getBallWithOriginalFrame:CGRectMake(((backViewWidth-ballWidth)-reverseSqrtLength), reverseSqrtLength, ballWidth, ballWidth)
    endFrame:CGRectMake(reverseSqrtLength, ((backViewWidth-ballWidth)-reverseSqrtLength), ballWidth, ballWidth)];
    
    //东南角
    AimationBall *bottomRightBall = [self getBallWithOriginalFrame:CGRectMake(((backViewWidth-ballWidth)-reverseSqrtLength), ((backViewWidth-ballWidth)-reverseSqrtLength), ballWidth, ballWidth)
    endFrame:CGRectMake(reverseSqrtLength, reverseSqrtLength, ballWidth, ballWidth)];
    
    /// 开启动画
    NSArray *array = @[
        levelLeftBall,
        levelRightBall,
        verticalTopBall,
        verticalBottomBall,
        bottomLeftBall,
        topRightBall,
        topLeftBall,
        bottomRightBall,
    ];
    
    [self startAnimationWithBalls:array];
}

/// 开启动画
- (void)startAnimationWithBalls:(NSArray *)balls {
    [[XYGCDTimer shareTimer] startTimerWithTimeInterVal:animationTime*2 circleBlock:^{
        [UIView animateWithDuration:animationTime animations:^{
            for (AimationBall *ball in balls) {
                ball.frame = ball.endFrame;
            }
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:animationTime animations:^{
                for (AimationBall *ball in balls) {
                    ball.frame = ball.originalFrame;
                }
            }];
        }];
    }];
}

- (AimationBall *)getBallWithOriginalFrame:(CGRect)originalFrame endFrame:(CGRect)endFrame{
    AimationBall *ball = [[AimationBall alloc] initWithFrame:originalFrame];
    ball.originalFrame = originalFrame;
    ball.endFrame = endFrame;
    ball.backgroundColor = [UIColor randomColor];
    [self.backView addSubview:ball];
    
    return ball;
}

- (void)dealloc {
    [[XYGCDTimer shareTimer] removeTimer];
}

@end
