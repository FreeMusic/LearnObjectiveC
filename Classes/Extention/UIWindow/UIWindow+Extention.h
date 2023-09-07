//
//  UIWindow+Extention.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/7/19.
//  Copyright © 2023 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (Extention)

/*!
 @method topMostController
 
 @return Returns the current Top Most ViewController in hierarchy.
 */
- (UIViewController*)jk_topMostController;

/*!
 @method currentViewController
 
 @return Returns the topViewController in stack of topMostController.
 */
- (UIViewController*)jk_currentViewController;

@end

NS_ASSUME_NONNULL_END
