//
//  BaseViewController.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSArray *Messages;

@end

@interface ObjectiveModel: NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vcName;


@property (nonatomic, strong) UIViewController *vc;//


+ (ObjectiveModel *)initTitle:(NSString *)title vcName:(NSString *)vcName;

+ (ObjectiveModel *)initTitle:(NSString *)title vc:(UIViewController *)vc;

@end

