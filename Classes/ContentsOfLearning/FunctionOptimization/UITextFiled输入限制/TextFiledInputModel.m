//
//  TextFiledInputModel.m
//  LearnObjectiveC
//
//  Created by 碳银TW on 2020/4/30.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextFiledInputModel.h"

@implementation TextFiledInputModel

+ (instancetype)initTitle:(NSString *)title content:(NSString *)content{
    TextFiledInputModel *model = [[TextFiledInputModel alloc] init];
    model.content = content;
    model.title = title;
    
    return model;
}

+ (NSArray *)createTextFiledContentArray{
    
    NSArray *modelArray = @[
        [TextFiledInputModel initTitle:@"姓名" content:@""],
        [TextFiledInputModel initTitle:@"身份证号" content:@""],
        [TextFiledInputModel initTitle:@"银行卡号" content:@""],
        [TextFiledInputModel initTitle:@"手机号" content:@""],
        [TextFiledInputModel initTitle:@"所在省" content:@""],
        [TextFiledInputModel initTitle:@"所在市" content:@""],
        [TextFiledInputModel initTitle:@"所在区" content:@""],
        [TextFiledInputModel initTitle:@"详细地址" content:@""],
        [TextFiledInputModel initTitle:@"邮政编码" content:@""],
        [TextFiledInputModel initTitle:@"身份证签发机关" content:@""],
        [TextFiledInputModel initTitle:@"单位名称" content:@""],
        [TextFiledInputModel initTitle:@"单位所在省" content:@""],
        [TextFiledInputModel initTitle:@"单位所在市" content:@""],
        [TextFiledInputModel initTitle:@"单位所在区" content:@""],
        [TextFiledInputModel initTitle:@"单位详细地址" content:@""],
        [TextFiledInputModel initTitle:@"单位邮政编码" content:@""],
        [TextFiledInputModel initTitle:@"女朋友姓名" content:@""],
        [TextFiledInputModel initTitle:@"女朋友手机号" content:@""],
    ];
    
    return modelArray;
}

@end
