//
//  MVC_View.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/14.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVC_Model;

@interface MVC_View : UIView

@property (nonatomic, strong) MVC_Model *model;

@end
