//
//  LXYImageBrowserManger.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/4.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "LXYImageBrowserManger.h"
#import "LXYImageBrowserViewController.h"
#import "LXYImageBrowserHeader.h"

@interface LXYImageBrowserManger ()

@property(nonatomic,copy)NSArray * imageUrls;
@property(nonatomic,copy)NSArray * originImageViews;

@property(nonatomic,weak)UIViewController * controller;
@property(nonatomic,copy)ForceTouchActionBlock forceTouchActionBlock;
@property(nonatomic,copy)NSArray * previewActionTitls;

@end

@implementation LXYImageBrowserManger

+ (id _Nonnull )imageBrowserMangerWithUrlStr:(NSArray<NSString *>*)imageUrls originImageViews:(NSArray<UIImageView *>*)originImageViews originController:(UIViewController *)controller {
    
    LXYImageBrowserManger *imageBrowserManger = [[LXYImageBrowserManger alloc] init];
    imageBrowserManger.imageUrls = imageUrls;
    imageBrowserManger.originImageViews = originImageViews;
    imageBrowserManger.controller = controller;
    
    return imageBrowserManger;
}

- (void)showImageBrowser {
    LXYImageBrowserViewController *imageBrowserViewController = [[LXYImageBrowserViewController alloc] initWithUrlStr:self.imageUrls originImageViews:self.originImageViews selectPage:self.selectPage];
    [self.controller presentViewController:imageBrowserViewController animated:YES completion:nil];
}

@end
