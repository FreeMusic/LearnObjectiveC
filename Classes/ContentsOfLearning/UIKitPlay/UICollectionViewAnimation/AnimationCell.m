//
//  AnimationCell.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/8.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "AnimationCell.h"

@interface AnimationCell ()

@property (nonatomic, strong) UIImageView *mainImageView;//

@end

@implementation AnimationCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mainImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_mainImageView];
        
    }
    return self;
}

@end
