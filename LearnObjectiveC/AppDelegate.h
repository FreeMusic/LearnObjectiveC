//
//  AppDelegate.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef double XYLocationDegress;

struct XYLocationCoordinate2D {
    XYLocationDegress latitude;
    XYLocationDegress longitude;
};

typedef struct XYLocationCoordinate2D XYLocationCoordinate2D;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, getter=hasEnable) BOOL enable;///

@end

