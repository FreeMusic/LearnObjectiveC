//
//  LOCTool.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/7/19.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "LOCTool.h"
#import "UIWindow+Extention.h"

const char* breaken_pathes[] = {
  "/Applications/Cydia.app",
  "/Library/MobileSubstrate/MobileSubstrate.dylib",
  "/bin/bash",
  "/usr/sbin/sshd",
  "/etc/apt"
};

#define GL_DEV_TEAM @"FWGGQF6Q9C"
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

@implementation LOCTool

/// App安全检测---篡改和二次签名打包的风险
+ (void)appSafeCheck {
  NSString *bundleIDPrefix = [self bundleIDPrefix];
  if (![bundleIDPrefix isEqualToString:GL_DEV_TEAM]) {
      [self exitApplication];
  }
  if ([self checkMach_O]) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [self exitApplication];
    });
  }
}

+ (NSString *)bundleIDPrefix {
  static NSString *buPreStr=nil;
  if (buPreStr.length==0) {
    @try {
      NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys: (id)kSecClassGenericPassword, kSecClass, @"bundleIDPrefix", kSecAttrAccount, @"", kSecAttrService, (id)kCFBooleanTrue, kSecReturnAttributes, nil];
      CFDictionaryRef result = nil;
      OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
      if (status == errSecItemNotFound) status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
      if (status != errSecSuccess) return nil;
      NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(id)kSecAttrAccessGroup];
      NSArray *components = [accessGroup componentsSeparatedByString:@"."];
      buPreStr = [[components objectEnumerator] nextObject]; CFRelease(result);
    }@catch(NSException *ex) {}
  }return buPreStr;
}

// 退出应用
+ (void)exitApplication{
  //运行一个不存在的方法,退出界面更加圆滑
  [self performSelector:@selector(exitApp)];
  abort();
}

// 越狱检测
+ (BOOL)prisonBreakenDetection
{
  if ([self isSimulator] == YES){return NO;}
  
  for (int i = 0; i < ARRAY_SIZE(breaken_pathes); i++) {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:breaken_pathes[i]]]) {
      return YES;
    }
  }
  return NO;
}

// 是否模拟器
+ (BOOL)isSimulator {
#if TARGET_OS_SIMULATOR
  return YES;
#else
  return NO;
#endif
}

// 判断Mach-O文件否被篡改
+ (BOOL)checkMach_O
{
  NSBundle *bundle = [NSBundle mainBundle];
  NSDictionary *info = [bundle infoDictionary];
  if ([info objectForKey: @"SignerIdentity"] != nil){
    //存在这个key，则说明被二次打包了
    return YES;
  }
  return NO;
}

/**
 *  返回当前控制器(可能是跟控制器)
 */
+ (UIViewController *)getCurrentVC
{
    return [[UIApplication sharedApplication].keyWindow jk_currentViewController];
}

@end
