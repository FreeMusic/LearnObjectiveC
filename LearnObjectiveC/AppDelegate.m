//
//  AppDelegate.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <Bugly/Bugly.h>

@interface AppDelegate ()<BuglyDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window = [[UIWindow alloc] init];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = naviVC;
    //初始化Bugly
    [self initBuglyConfigure];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSLog(@"url = %@", url);
    
    return YES;
}
/**
 初始化Bugly
 */
- (void)initBuglyConfigure {
    
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.debugMode = YES;
    config.blockMonitorEnable = YES;
    //设置被卡住的阈值时间，当停留时间>阈值时间，它将记录一个事件，并在应用程序启动下报告数据。默认值为3.5s
    config.blockMonitorTimeout = 1.5;
    config.channel = @"Bugly";
    config.delegate = self;
    config.consolelogEnable = NO;
    config.viewControllerTrackingEnable = NO;
    [Bugly startWithAppId:@"a74b771cad"];
    [Bugly startWithAppId:@"a74b771cad" developmentDevice:YES config:config];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
