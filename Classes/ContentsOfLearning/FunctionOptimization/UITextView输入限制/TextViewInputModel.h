//
//  TextViewInputModel.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/19.
//  Copyright © 2020 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextViewInputModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) int maxInputLength;///
@property (nonatomic, copy) NSString *inputType;///


+ (NSArray *)inputTextViewContentModel;

@end

NS_ASSUME_NONNULL_END
