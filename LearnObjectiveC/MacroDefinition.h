//
//  MacroDefinition.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h

/**
 *  如果不需要log,把1改成0
 */
#define  myTest  1
#if myTest

#define RYQLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define RYQLog(FORMAT, ...) nil
#endif

//电池栏
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏
#define kNavBarHeight 44.0
//tabbar高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
//导航+电池栏
#define NavigationBarHeight (kStatusBarHeight + kNavBarHeight)
//安全区底部高度
#define KSafeBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34.0:0)

/**
 *  屏幕尺寸宽和高
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/**
 *  比例系数适配  宽度比例系数
 */
#define m6PScale              kScreenWidth/1242.0
#define m6Scale               kScreenWidth/750.0
#define m5Scale               kScreenWidth/640.0

#define m6HeightScale         kScreenHeight/1334.0

//存储到本地
#define UserDefaults(Object, Key)\
[[NSUserDefaults standardUserDefaults] setValue:Object forKey:Key];\

#define defaults [NSUserDefaults standardUserDefaults]

/********颜色相关宏***********/
//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kColor(R,G,B,A) [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define DarkNavigationColor UIColorFromRGB(0xf44351)
#define TintNavigationColor UIColorFromRGB(0xff5d34)

/**
 *  背景颜色
 */
#define backGroundColor [UIColor colorWithRed:245.0 / 255.0 green:245.0 / 255.0 blue:245.0/255.0 alpha:1.0]
/** 弱引用 */
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WHITE_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
// 透明色
#define CLEAR_COLOR [UIColor clearColor]
// 黑色
#define BLACK_COLOR [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]
// 浅色
#define LIGHT_COLOR [UIColor colorWithRed:175.0/255.0 green:175.0/255.0 blue:175.0/255.0 alpha:1.0]
// 深色
#define DARK_COLOR [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1.0]
// 自适应设备宽度
#define ADAPTWidth(w) (kScreenWidth / 375 * (w))
// 自适应设备高度
#define ADAPTHeight(h) (kScreenHeight / 667 * (h))
// 字颜色
#define TITLE_COLOR [UIColor colorWithRed:244.0/255.0 green:67.0/255.0 blue:81.0/255.0 alpha:1.0]
// 导航栏 渐变
#define NAVFIRST_COLOR [UIColor colorWithRed:255.0/255.0 green:93.0/255.0 blue:52.0/255.0 alpha:1.0]
#define NAVSECOND_COLOR [UIColor colorWithRed:244.0/255.0 green:67.0/255.0 blue:81.0/255.0 alpha:1.0]
// 按钮 渐变
#define BUTTONFIRST_COLOR [UIColor colorWithRed:255.0/255.0 green:93.0/255.0 blue:52.0/255.0 alpha:1.0]
#define BUTTONSECOND_COLOR [UIColor colorWithRed:244.0/255.0 green:67.0/255.0 blue:81.0/255.0 alpha:1.0]
// 字体设置
#define ZLMFONTSET_M(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]
#define ZLMFONTSET_R(s) [UIFont fontWithName:@"PingFangSC-Regular" size:s]
#define ZLMFONTSET_L(s) [UIFont fontWithName:@"PingFangSC-Light" size:s]
#define ZLMFONTSET_BMT(s) [UIFont fontWithName:@"Arial-BoldMT" size:s]
#define ZLMFONTSET_MT(s) [UIFont fontWithName:@"ArialMT" size:s]
#define ZLMFONTSET_S(s) [UIFont systemFontOfSize:s]
#define ZLMFONTSET(f,s) [UIFont fontWithName:f size:s]
/**
 发送红包的时候只允许输入数字
 */
#define kAlphaNum @"1234567890."
/**
 地址
 */
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject]

#define UserDataPath [DocumentPath stringByAppendingPathComponent:@"User.data"]
///**
// 强转字符串
// */
//#define String(myid) [NSString stringWithFormat:@"%@", myid]
// 背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]

#endif /* MacroDefinition_h */
