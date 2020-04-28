//
//  TextFiledInputLimitVC.m
//  LearnObjectiveC
//
//  Created by 碳银TW on 2020/4/28.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextFiledInputLimitVC.h"

@interface TextFiledInputLimitVC ()

@end

@implementation TextFiledInputLimitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITextField *textField = [UITextField textFiledWithPlaceHolder:@"请输入" textColor:[UIColor redColor] font:16 addSubView:self.view];
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.layer.borderWidth = 1;
    textField.frame = CGRectMake(20, 200, 300, 50);
    
    //*******此处用法是 限制长度和输入规则 并且有输入结果回调*********//
    [textField setTextFieldInputMax:10 inputRules:@"1234567890" editValueBlock:^(UITextField * _Nonnull textField) {
        RYQLog(@"*********%@*********", textField.text);
    }];
    
    //*******如果限制长度和输入规则和有输入结果回调想用到其中某一种 可以灵活以下设置*********//
    //    [textField setInputMax:10];
    //    [textField setInputRules:@"123456789"];
    //    [textField setEditValueBlock:^(UITextField * _Nonnull textField) {
    //        NSLog(@"*********%@*********", textField.text);
    //    }];
}


@end
