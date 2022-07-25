//
//  ElemCell.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/22.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "ElemCell.h"

@interface ElemCell ()

@property (nonatomic, strong) UILabel *textLabel;///

@end

@implementation ElemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        _textLabel = [UILabel LabelWithColor:[UIColor blackColor] andTextFont:15 andText:@"" addSubView:self];
        [_textLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.centerX);
            make.centerY.equalTo(self.centerY);
        }];
    }
    return self;
}

-(void)setLabelText:(NSString *)labelText {
    _labelText = labelText;
    _textLabel.text = labelText;
}

@end
