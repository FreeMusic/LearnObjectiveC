//
//  LXYImageBrowserManger.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ForceTouchActionBlock)(NSInteger selectIndex, NSString * _Nonnull title);

@interface LXYImageBrowserManger : NSObject
@property(nonatomic,assign)NSInteger selectPage; ///< 选中哪一个imageView

/**
 初始化 Manger
 
 @param imageUrls 各个图片大图的url
 @param originImageViews 原始的小图
 @param controller 小图所有的视图控制器
 @return manger
 */
+ (id _Nonnull )imageBrowserMangerWithUrlStr:(NSArray<NSString *>*_Nullable)imageUrls originImageViews:(NSArray<UIImageView *>*)originImageViews originController:(UIViewController *)controller;

/**
 用户点击 _Nonnull  _Nullable 小图，进入图片查看大图。
 */
- (void)showImageBrowser;

@end
