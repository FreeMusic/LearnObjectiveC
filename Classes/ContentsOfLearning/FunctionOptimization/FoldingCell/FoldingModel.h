//
//  FoldingModel.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/7/25.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FoldingModel : NSObject

@property (nonatomic, strong) NSString *text;///
@property (nonatomic, assign) CGFloat width;///
///



- (instancetype)initWithText: (NSString *)text;

@end

NS_ASSUME_NONNULL_END
