//
//  AimationBall.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/13.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "AimationBall.h"

@implementation AimationBall

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BLACK_COLOR;
        self.layer.cornerRadius = self.lz_width/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

@end
