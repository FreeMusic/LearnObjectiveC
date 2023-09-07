//
//  UIWindow+Extention.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/7/19.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "UIWindow+Extention.h"

@implementation UIWindow (Extention)

- (UIViewController*)jk_topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])    topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)jk_currentViewController;
{
    UIViewController *currentViewController = [self jk_topMostController];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

@end
