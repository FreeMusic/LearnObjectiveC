//
//  PhoneBookCell.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2021/12/27.
//  Copyright © 2021 橘子. All rights reserved.
//

#import "PhoneBookCell.h"

@interface PhoneBookCell ()

@property (nonatomic, strong) UILabel *titleLabel;///
@property (nonatomic, strong) UILabel *rightLabel;///

@end

@implementation PhoneBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        self.contentView.backgroundColor = [UIColor yellowColor];
        
        self.titleLabel = [UILabel LabelWithColor:UIColor.redColor andTextFont:30 andText:@"111111" addSubView:self.contentView];
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.centerY.equalTo(self.contentView.centerY);
        }];
        
        self.rightLabel = [UILabel LabelWithColor:[UIColor redColor] andTextFont:30 andText:@"222222" addSubView:self.contentView];
        [self.rightLabel makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-16);
            make.centerY.equalTo(self.contentView.centerY);
        }];
    }
    
    return self;
}

- (void)setValue:(NSDictionary *)value {
    self.titleLabel.text = [[value valueForKey:@"name"] length] > 0 ? [value valueForKey:@"name"] : @"没有名字";
    self.rightLabel.text = [[value valueForKey:@"phone"] length] > 0 ? [value valueForKey:@"phone"] : @"没有电话";
}

@end
