//
//  LXYImageBrowserViewController.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXYImageBrowserViewController : UIViewController

/**
 初始化查看大图的controller

 @param imageUrls 所有大图的数组
 @param originImageViews 所有小图原始的imageView数组
 @param selectPage 选中的是第几个
 @return 大图的controller
 */
- (id)initWithUrlStr:(NSArray<NSString *>*)imageUrls originImageViews:(NSArray<UIImageView *>*)originImageViews selectPage:(NSInteger)selectPage;

@end

NS_ASSUME_NONNULL_END
