//
//  TextViewInputCell.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/19.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextViewInputCell.h"

@interface TextViewInputCell ()

@property (nonatomic, strong) UITextView *inputView;//输入框
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation TextViewInputCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        
        //标题
        self.titleLabel = [UILabel LabelWithColor:BLACK_COLOR andTextFont:30 andText:@"" addSubView:self.contentView];
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.centerY.equalTo(self.contentView.centerY);
        }];
        //输入框
        self.inputView = [[UITextView alloc] init];
        _inputView.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.inputView];
        [self.inputView makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-16);
            make.left.equalTo(self.titleLabel.right).offset(16);
            make.centerY.equalTo(self.contentView.mas_centerY);
        }];
    }
    
    return self;
}

- (void)setInputModel:(TextViewInputModel *)inputModel {
    _inputModel = inputModel;
    self.titleLabel.text = inputModel.title;
}

@end
