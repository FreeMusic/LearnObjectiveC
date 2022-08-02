//
//  ConfigurationConst.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef ConfigurationConst_h
#define ConfigurationConst_h

/**
 *  屏幕尺寸宽和高
 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat minimumLineSpacing = 10;// Y
static CGFloat minimumInteritem = 10;// X
///cell的大小位置计算完毕回调
typedef void(^FinishCaculateFlowLayoutAttributesBlock)(NSArray *attributes);


#endif /* ConfigurationConst_h */
