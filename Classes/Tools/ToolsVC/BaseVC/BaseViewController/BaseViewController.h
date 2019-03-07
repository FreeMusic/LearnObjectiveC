//
//  BaseViewController.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSArray *Messages;

@end

@interface ObjectiveModel: NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIViewController *vc;

+ (ObjectiveModel *)initTitle:(NSString *)title vc:(UIViewController *)vc;

@end

