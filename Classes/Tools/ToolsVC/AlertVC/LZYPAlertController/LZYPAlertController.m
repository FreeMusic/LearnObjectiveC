//
//  LZYPAlertController.m
//  LZYP
//
//  Created by sxy on 2019/11/7.
//  Copyright © 2019 LZYP-iOS-Andrew. All rights reserved.
//

#import "LZYPAlertController.h"

@interface LZYPAlertController ()

@end

@implementation LZYPAlertController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

/// ActionSheet 模式
/// @param cancleAction 取消按钮的回调
/// @param titleContents 其他操作方式标题
/// @param otherAction 其他操作方式回调
+ (void)initActionSheetWithCancleAction:(nullable ActionSheetCancleBlock)cancleAction
                              presentVC:(UIViewController *)presentVC
                          titleContents:(NSArray *)titleContents otherAction:(ActionSheetOtherActionBlock)otherAction{
  LZYPAlertController *actionSheet = [[self alloc] init];
  
  UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                 handler:^(UIAlertAction * action) {
    if (cancleAction) {
      cancleAction();
    }
  }];
  
  for (int i = 0; i < titleContents.count; i++) {
    UIAlertAction *otherActionSheet = [UIAlertAction actionWithTitle:titleContents[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      if (otherAction) {
        otherAction(i);
      }
    }];
    [actionSheet addAction:otherActionSheet];
  }
  
  [actionSheet addAction:cancel];
  [presentVC presentViewController:actionSheet animated:YES completion:nil];
  presentVC.modalPresentationStyle = UIModalPresentationFullScreen;
}

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
                   confirmAction:(ActionAlertConfirmBlock)confirmAction{
  LZYPAlertController *actionAlert = [self alertControllerWithTitle:(title.length) ? title : @"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *cancle = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    if (cancleAction) {
      cancleAction();
    }
  }];
  
  UIAlertAction *confirm = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    if (confirmAction) {
      confirmAction();
    }
  }];
  
  [actionAlert addAction:cancle];
  [actionAlert addAction:confirm];
  
  [presentVC presentViewController:actionAlert animated:YES completion:nil];
  presentVC.modalPresentationStyle = UIModalPresentationFullScreen;
}

/// ActionAlert 模式  取消按钮默认
/// @param title 标题
/// @param message 提示信息
/// @param confirmTitle 确认按钮标题
/// @param confirmAction 确认按钮回调
+ (void)initActionAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                       presentVC:(UIViewController *)presentVC
                    confirmTitle:(NSString *)confirmTitle
                   confirmAction:(ActionAlertConfirmBlock)confirmAction{
  [self initActionAlertWithTitle:title message:message presentVC:presentVC cancleTitle:@"取消" cancleAction:nil confirmTitle:confirmTitle confirmAction:confirmAction];
}

/// ActionAlert 模式  只有确认按钮
/// @param title 标题
/// @param message 提示信息
+ (void)initActionAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                       presentVC:(UIViewController *)presentVC{
  LZYPAlertController *actionAlert = [self alertControllerWithTitle:(title.length) ? title : @"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
  }];
  
  [actionAlert addAction:confirm];
  
  [presentVC presentViewController:actionAlert animated:YES completion:nil];
  presentVC.modalPresentationStyle = UIModalPresentationFullScreen;
}

/// ActionAlert 模式  只有确认按钮  确认按钮有点击回调事件
/// @param title 标题
/// @param message 提示信息
/// @param confirmAction 确认按钮回调事件
+ (void)initActionAlertWithTitle:(NSString *)title
                         message:(NSString *)message
                       presentVC:(UIViewController *)presentVC
                   confirmAction:(ActionAlertConfirmBlock)confirmAction {
  LZYPAlertController *actionAlert = [self alertControllerWithTitle:(title.length) ? title : @"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    if (confirmAction) {
      confirmAction();
    }
  }];
  
  [actionAlert addAction:confirm];
  
  [presentVC presentViewController:actionAlert animated:YES completion:nil];
  presentVC.modalPresentationStyle = UIModalPresentationFullScreen;
}

@end

