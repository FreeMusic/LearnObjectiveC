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
#import <sys/utsname.h>
//首先导入头文件信息
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
 
#define IOS_CELLULAR    @"pdp_ip0"
//有些分配的地址为en0 有些分配的en1
#define IOS_WIFI2       @"en2"
#define IOS_WIFI1       @"en1"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"  vpn很少用到可以注释
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
#import "LOCTool.h"
#import "AESTool.h"
#import <MapKit/MapKit.h>

@interface AppDelegate ()<BuglyDelegate, CLLocationManagerDelegate>

@property (nonatomic, assign) UIBackgroundTaskIdentifier backgrounTask;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic, strong) CLLocationManager *locationManager;//拍照定位

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [LOCTool appSafeCheck];
    ViewController *VC = [[ViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:VC];
    self.window = [[UIWindow alloc] init];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = naviVC;
    //初始化Bugly
    [self initBuglyConfigure];
    
    XYLog(@"%@", [self getIPAddress:NO]);
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@(1), @(2), @(3), @(5)]];
    NSMutableArray *cpyArray = array.mutableCopy;
    array[0] = @"1212"; cpyArray[0] = @(3333);
//    [self beginLocation];
    XYLog(@"%@   %@", array, cpyArray);
    
    return YES;
    
}

- (void)beginLocation {
    self.locationManager= [CLLocationManager new];
    CLLocationDistance distance = 500;
    NSTimeInterval time = 20;
    self.locationManager.delegate = self;
    [self.locationManager allowDeferredLocationUpdatesUntilTraveled:distance timeout:time];
    [self.locationManager requestAlwaysAuthorization];
    @try {
        self.locationManager.allowsBackgroundLocationUpdates=YES;
    } @catch (NSException *exception) {
        NSLog(@"异常：%@", exception);
    } @finally {

    }
    [self.locationManager startUpdatingLocation];
}

//获取一次定位，然后关掉manager
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //防止多次调用
    
    CLLocation *currentLocation = [locations lastObject];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
//
//    if (locationAge > 5.0) return;
//
//    if (currentLocation.horizontalAccuracy < 0) return;
    
    XYLog(@"%f    %f", coord.longitude, coord.latitude);
}


//获取设备当前网络IP地址（是获取IPv4 还是 IPv6）
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    //从字典中按顺序查询 查询到不为空即停止（顺序为4G(3G)、Wi-Fi、局域网）
    NSArray *searchArray = preferIPv4 ?
    @[ /*IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6,*/ IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_WIFI2 @"/" IP_ADDR_IPv4, IOS_WIFI1 @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv4] :
    @[ /*IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4,*/ IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_WIFI2 @"/" IP_ADDR_IPv6, IOS_WIFI1 @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv6] ;
 
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
 
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
        {
            address = addresses[key];
            if(address) *stop = YES;
        } ];
    return address ? address : @"0.0.0.0";
}
 
//获取所有相关IP信息
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
 
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

//获取请求参数请求头
- (NSDictionary *)getRequestHeader {
    UIDevice *device = [UIDevice currentDevice];
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSString *appVerion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *data = @{
        @"appType": @"2",// 1 光良 ；2 协同；
        @"sysVersion": [device.systemName stringByAppendingString:device.systemVersion],//系统版本
        @"device": [self getDeviceType:@"iPhone14,0"],//设备型号
        @"version": appVerion,//App版本
    };
    
    return data;
}

- (NSString *)getDeviceType:(NSString *)key {
    NSString *deviceTypeName = @"";
    NSDictionary *dic = @{
        // iPhone
        @"iPhone1,1":@"iPhone 2G",
        @"iPhone1,2":@"iPhone 3G",
        @"iPhone2,1":@"iPhone 3GS",
        @"iPhone3,1":@"iPhone 4",
        @"iPhone3,2":@"iPhone 4",
        @"iPhone3,3":@"iPhone 4",
        @"iPhone4,1":@"iPhone 4S",
        @"iPhone5,1":@"iPhone 5",
        @"iPhone5,2":@"iPhone 5",
        @"iPhone5,3":@"iPhone 5c",
        @"iPhone5,4":@"iPhone 5c",
        @"iPhone6,1":@"iPhone 5s",
        @"iPhone6,2":@"iPhone 5s",
        @"iPhone7,1":@"iPhone 6 Plus",
        @"iPhone7,2":@"iPhone 6",
        @"iPhone8,1":@"iPhone 6s",
        @"iPhone8,2":@"iPhone 6s Plus",
        @"iPhone8,4":@"iPhone SE",
        @"iPhone9,1":@"iPhone 7",
        @"iPhone9,3":@"iPhone 7",
        @"iPhone9,2":@"iPhone 7 Plus",
        @"iPhone9,4":@"iPhone 7 Plus",
        @"iPhone10,1":@"iPhone 8",
        @"iPhone10,4":@"iPhone 8",
        @"iPhone10,2":@"iPhone 8 Plus",
        @"iPhone10,5":@"iPhone 8 Plus",
        @"iPhone10,3":@"iPhone X",
        @"iPhone10,6":@"iPhone X",
        @"iPhone11,2":@"iPhone XS",
        @"iPhone11,6":@"iPhone XS MAX",
        @"iPhone11,8":@"iPhone XR",
        @"iPhone12,1":@"iPhone 11",
        @"iPhone12,3":@"iPhone 11 Pro",
        @"iPhone12,5":@"iPhone 11 Pro Max",
        @"iPhone12,8":@"iPhone SE (2nd generation)",
        @"iPhone13,1":@"iPhone 12 mini",
        @"iPhone13,2":@"iPhone 12",
        @"iPhone13,3":@"iPhone 12 Pro",
        @"iPhone13,4":@"iPhone 12 Pro Max",
        @"iPhone14,2":@"iPhone 13 Pro",
        @"iPhone14,3":@"iPhone 13 Pro Max",
        @"iPhone14,4":@"iPhone 13 mini",
        @"iPhone14,5":@"iPhone 13",
    };
    deviceTypeName = [dic valueForKey:key];
    deviceTypeName = deviceTypeName ? deviceTypeName : key;
    
    return deviceTypeName;
}


- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSLog(@"url = %@", url);
    
    return YES;
}
/**
 初始化Bugly
 */
- (void)initBuglyConfigure {
    
    //    BuglyConfig *config = [[BuglyConfig alloc] init];
    //    config.debugMode = YES;
    //    config.blockMonitorEnable = YES;
    //    //设置被卡住的阈值时间，当停留时间>阈值时间，它将记录一个事件，并在应用程序启动下报告数据。默认值为3.5s
    //    config.blockMonitorTimeout = 1.5;
    //    config.channel = @"Bugly";
    //    config.delegate = self;
    //    config.consolelogEnable = NO;
    //    config.viewControllerTrackingEnable = NO;
    //    [Bugly startWithAppId:@"a74b771cad"];
    //    [Bugly startWithAppId:@"a74b771cad" developmentDevice:YES config:config];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
