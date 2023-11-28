//
//  UtilClass.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/11/6.
//  Copyright © 2023 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilClass : NSObject

/// 截取当前屏幕作为一张Image
+ (UIImage *)screenImageWithSize:(CGSize )imgSize;

@end

NS_ASSUME_NONNULL_END
