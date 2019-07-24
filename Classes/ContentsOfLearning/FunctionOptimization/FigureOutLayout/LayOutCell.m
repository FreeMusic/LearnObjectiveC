//
//  LayOutCell.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "LayOutCell.h"

@interface LayOutCell ()

@property (nonatomic, strong) UIView *layoutView;

@end

@implementation LayOutCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR_COLOR;
        
        self.layoutView = [UIView new];
        self.layoutView.backgroundColor = WHITE_COLOR;
//        self.layoutView.frame = CGRectMake(0, 0, frame.size.width*0.8, frame.size.height*0.8);
        self.layoutView.center = self.contentView.center;
        [self.contentView addSubview:self.layoutView];
    }
    return self;
}

- (void)zoomCardView{
    self.layoutView.frame = CGRectMake(0, 0, self.contentView.frame.size.width*0.3, self.contentView.frame.size.height*0.3);
    self.layoutView.center = self.contentView.center;
    [UIView animateWithDuration:1 animations:^{
        self.layoutView.frame = CGRectMake(0, 0, self.contentView.frame.size.width*0.8, self.contentView.frame.size.height*0.8);
        self.layoutView.center = self.contentView.center;
    }];
}

@end
