//
//  NSDictionary+CLLocation.h
//  LearnObjectiveC
//
//  Created by 孙晓阳 on 2019/4/5.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (CLLocation)

//图片的GPSDictionary转化为CLLocation对象
-(CLLocation*)locationFromGPSDictionary;

@end

NS_ASSUME_NONNULL_END
