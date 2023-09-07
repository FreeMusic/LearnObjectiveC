//
//  LOCTool.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/7/19.
//  Copyright © 2023 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LOCTool : NSObject

/// App安全检测---篡改和二次签名打包的风险
+ (void)appSafeCheck;

+ (UIViewController *)getCurrentVC;

@end

NS_ASSUME_NONNULL_END
