//
//  TextFiledInputModel.h
//  LearnObjectiveC
//
//  Created by 碳银TW on 2020/4/30.
//  Copyright © 2020 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextFiledInputModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

+ (NSArray *)createTextFiledContentArray;

@end

NS_ASSUME_NONNULL_END
