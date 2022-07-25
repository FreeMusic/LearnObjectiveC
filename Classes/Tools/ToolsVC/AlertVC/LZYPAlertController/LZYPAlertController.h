//
//  LZYPAlertController.h
//  LZYP
//
//  Created by sxy on 2019/11/7.
//  Copyright © 2019 LZYP-iOS-Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

//ActionSheet模式下取消按钮的回调
typedef void(^ActionSheetCancleBlock)(void);

typedef void(^ActionSheetOtherActionBlock)(NSUInteger index);

//ActionAlert模式下的回调
typedef void (^ActionAlertCancleBlock)(void);

typedef void (^ActionAlertConfirmBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface LZYPAlertController : UIAlertController


/// ActionSheet 模式
/// @param cancleAction 取消按钮的回调
/// @param titleContents 其他操作方式标题
/// @param otherAction 其他操作方式回调
+ (void)initActionSheetWithCancleAction:(nullable ActionSheetCancleBlock)cancleAction
                                  presentVC:(UIViewController *)presentVC
                                  titleContents:(NSArray *)titleContents otherAction:(ActionSheetOtherActionBlock)otherAction;


/// ActionAlert 模式
/// @param title 标题
/// @param message 提示信息
/// @param cancleTitle 取消按钮标题
/// @param cancleAction 取消按钮回调
/// @param confirmTitle 确认按钮标题
/// @param confirmAction 确认按钮回调
+ (void)initActionAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                               presentVC:(UIViewController *)presentVC
                             cancleTitle:(NSString *)cancleTitle cancleAction:(nullable ActionAlertCancleBlock)cancleAction
                            confirmTitle:(NSString *)confirmTitle
                           confirmAction:(ActionAlertConfirmBlock)confirmAction;

/// ActionAlert 模式  取消按钮默认
/// @param title 标题
/// @param message 提示信息
/// @param confirmTitle 确认按钮标题
/// @param confirmAction 确认按钮回调
+ (void)initActionAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                               presentVC:(UIViewController *)presentVC
                            confirmTitle:(NSString *)confirmTitle
                           confirmAction:(ActionAlertConfirmBlock)confirmAction;

/// ActionAlert 模式  只有确认按钮
/// @param title 标题
/// @param message 提示信息
+ (void)initActionAlertWithTitle:(NSString *)title
                                 message:(NSString *)message
                               presentVC:(UIViewController *)presentVC;

/// ActionAlert 模式  只有确认按钮  确认按钮有点击回调事件
/// @param title 标题
/// @param message 提示信息
/// @param confirmAction 确认按钮回调事件
+ (void)initActionAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                       presentVC:(UIViewController *)presentVC
                   confirmAction:(ActionAlertConfirmBlock)confirmAction;

@end

NS_ASSUME_NONNULL_END
