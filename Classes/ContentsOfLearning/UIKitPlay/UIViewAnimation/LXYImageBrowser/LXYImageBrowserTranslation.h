//
//  LXYImageBrowserTranslation.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LXYImageBrowserMainView;

NS_ASSUME_NONNULL_BEGIN

@interface LXYImageBrowserTranslation : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)BOOL isBrowserMainView;
@property(nonatomic,strong)LXYImageBrowserMainView * mainBrowserMainView;
@property(nonatomic,strong)UIView * browserControllerView;

@end

NS_ASSUME_NONNULL_END
