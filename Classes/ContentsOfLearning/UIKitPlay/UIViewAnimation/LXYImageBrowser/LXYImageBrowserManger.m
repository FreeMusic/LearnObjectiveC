//
//  LXYImageBrowserManger.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "LXYImageBrowserManger.h"

@interface LXYImageBrowserManger ()

@property (nonatomic, copy) NSArray *imageUrls;
@property (nonatomic, copy) NSArray *originImageViews;

@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, copy) ForceTouchActionBlock forceTouchActionBlock;
@property (nonatomic, copy) NSArray *previewActionTitles;///

@end

@implementation LXYImageBrowserManger

+ (id)imageBrowserMangerWithUrlStr:(NSArray<NSString *> *)imageUrls originImageViews:(NSArray<UIImageView *> *)originImageViews originController:(UIViewController *)controller forceTouch:(BOOL)forceTouchCapability forceTouchActionTitles:(NSArray<NSString *> *)titles forceTouchActionComplete:(ForceTouchActionBlock)forceTouchActionBlock {
    
    LXYImageBrowserManger *imageBrowserManger = [[LXYImageBrowserManger alloc] init];
    imageBrowserManger.imageUrls = imageUrls;
    imageBrowserManger.originImageViews = originImageViews;
    imageBrowserManger.controller = controller;
    
    return imageBrowserManger;
}



@end
