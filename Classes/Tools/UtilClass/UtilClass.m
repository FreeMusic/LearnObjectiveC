//
//  UtilClass.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/11/6.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "UtilClass.h"
#import "AppDelegate.h"

@implementation UtilClass

/// 截取当前屏幕作为一张Image
+ (UIImage *)screenImageWithSize:(CGSize )imgSize{
      UIGraphicsBeginImageContext(imgSize);
      CGContextRef context = UIGraphicsGetCurrentContext();
      AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate;
      [app.window.layer renderInContext:context];
      UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
      return img;
}

@end
