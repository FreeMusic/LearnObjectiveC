//
//  TextFiledInputLimitCell.m
//  LearnObjectiveC
//
//  Created by 碳银TW on 2020/4/30.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextFiledInputLimitCell.h"

static int normallength = 20;
static int idCardlength = 18;
static int phonelength = 11;
static int bankCardlength = 19;
static int postCodelength = 6;

NSString *idCardRules = @"0123456789X";
NSString *numberRules = @"0123456789";

@interface TextFiledInputLimitCell ()

@property (nonatomic, strong) UITextField *inputFiled;//输入框
@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation TextFiledInputLimitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = NO;
        //标题
        self.titleLabel = [UILabel LabelWithColor:BLACK_COLOR andTextFont:30 andText:@"" addSubView:self.contentView];
        [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(16);
            make.centerY.equalTo(self.contentView.centerY);
        }];
        //输入框
        self.inputFiled = [UITextField textFiledWithPlaceHolder:@"请输入内容" textColor:[UIColor redColor] font:30 addSubView:self.contentView];
        self.inputFiled.textAlignment = NSTextAlignmentRight;
        [self.inputFiled makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-16);
            make.left.equalTo(self.titleLabel.right).offset(16);
            make.top.bottom.equalTo(0);
        }];
    }
    
    return self;
}


- (void)setInputModel:(TextFiledInputModel *)inputModel{
    _inputModel = inputModel;
    self.titleLabel.text = inputModel.title;
    self.inputFiled.text = inputModel.content;
    
    int inputMax = normallength;
    NSString *inputRules = @"";
    self.inputFiled.keyboardType = UIKeyboardTypeDefault;
    if ([inputModel.title isEqualToString:@"身份证号"]) {
        inputMax = idCardlength;
        inputRules = idCardRules;
    }else if ([inputModel.title containsString:@"手机号"]){
        inputMax = phonelength;
        inputRules = numberRules;
        self.inputFiled.keyboardType = UIKeyboardTypeNumberPad;
    }else if ([inputModel.title containsString:@"银行卡号"]){
        inputMax = bankCardlength;
        inputRules = numberRules;
        self.inputFiled.keyboardType = UIKeyboardTypeNumberPad;
    }else if ([inputModel.title containsString:@"邮政编码"]){
        inputMax = postCodelength;
        inputRules = numberRules;
        self.inputFiled.keyboardType = UIKeyboardTypeNumberPad;
    }else if ([inputModel.title containsString:@"详细地址"]){
        inputMax = 0;
    }
    //*******此处用法是 限制长度和输入规则 并且有输入结果回调*********//
    //*******inputMax为0 则输入长度不受限制  inputRules 为空字符串 @"" 输入规则不受限制*********//
    [self.inputFiled setTextFieldInputMax:inputMax inputRules:inputRules editValueBlock:^(UITextField * _Nonnull textField) {
        RYQLog(@"%@：%@", inputModel.title, textField.text);
        inputModel.content = textField.text;
    }];
}

@end
