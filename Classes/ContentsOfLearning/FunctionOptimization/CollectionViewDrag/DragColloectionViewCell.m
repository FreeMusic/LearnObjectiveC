//
//  DragColloectionViewCell.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/10/21.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "DragColloectionViewCell.h"

@interface DragColloectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;///

@end

@implementation DragColloectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [UILabel LabelWithColor:[UIColor redColor] andTextFont:15 andText:@"" addSubView:self];
        self.backgroundColor = [UIColor greenColor];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY);
        }];
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

@end
