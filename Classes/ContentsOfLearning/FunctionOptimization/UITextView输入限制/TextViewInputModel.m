//
//  TextViewInputModel.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/19.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextViewInputModel.h"

@implementation TextViewInputModel

+ (instancetype)initWithTitle:(NSString *)title content:(NSString *)content maxInputLength:(int)maxInputLength inputType:(NSString *)inputType{
    TextViewInputModel *model = [[TextViewInputModel alloc] init];
    model.title = title;
    model.content = content;
    model.maxInputLength = maxInputLength;
    model.inputType = inputType;
    
    return model;
}

+ (NSArray *)inputTextViewContentModel {
    return @[
        [self initWithTitle:@"地址" content:@"" maxInputLength:30 inputType:@""],
    ];
}

@end
