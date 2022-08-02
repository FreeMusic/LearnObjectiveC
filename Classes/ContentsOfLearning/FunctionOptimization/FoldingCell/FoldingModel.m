//
//  FoldingModel.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "FoldingModel.h"

@interface FoldingModel ()

@end

@implementation FoldingModel

- (instancetype)initWithText: (NSString *)text {
    if (self = [super init]) {
        self.text = text;
        CGFloat width = [self caculateStringSizeWithText:text].width;
        self.width = width + 20;
    }
    
    return self;
}

- (CGSize) caculateStringSizeWithText: (NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //最大宽度为300，最大高度为200
    CGSize size = [text boundingRectWithSize:CGSizeMake(kScreenWidth, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15] ,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
     
    return size;
}

@end
