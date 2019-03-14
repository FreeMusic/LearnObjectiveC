//
//  MVC_View.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/14.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MVC_View.h"
#import "MVC_Model.h"

@interface MVC_View ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation MVC_View

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.frame = CGRectMake(0,0, 200, 50);
        self.titleLabel.text = @"";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor grayColor];
        self.titleLabel.userInteractionEnabled = YES;
        self.titleLabel.center = self.center;
        [self addSubview:self.titleLabel];
        
    }
    
    return self;
}

- (void)setModel:(MVC_Model *)model{
    _model = model;
    self.titleLabel.text = model.title;
}

@end
