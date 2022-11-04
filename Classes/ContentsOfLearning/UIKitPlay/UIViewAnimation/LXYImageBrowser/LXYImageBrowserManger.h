//
//  LXYImageBrowserManger.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ForceTouchActionBlock)(NSUInteger selectIndex, NSString * _Nonnull title);

NS_ASSUME_NONNULL_BEGIN

@interface LXYImageBrowserManger : NSObject

@property (nonatomic, assign) NSUInteger selectPage;///选中哪一个imageView

/**
 初始化 Manger
 
 @param imageUrls 各个图片大图的url
 @param originImageViews 原始的小图
 @param controller 小图所有的视图控制器
 @param forceTouchCapability 是否开启3Dtouch
 @param titles 3Dtouch 上滑事件的title，可为 nil
 @param forceTouchActionBlock 设置的3Dtouch 上滑事件的的回调，可为 nil
 @return manger
 */
+ (id)imageBrowserMangerWithUrlStr:(NSArray<NSString *>*)imageUrls originImageViews:(NSArray<UIImageView *>*)originImageViews originController:(UIViewController *)controller forceTouch:(BOOL)forceTouchCapability forceTouchActionTitles:(nullable NSArray <NSString *>*)titles forceTouchActionComplete:(nullable ForceTouchActionBlock)forceTouchActionBlock;

/**
 用户点击小图，进入图片查看大图。
 */
- (void)showImageBrowser;

@end

NS_ASSUME_NONNULL_END
