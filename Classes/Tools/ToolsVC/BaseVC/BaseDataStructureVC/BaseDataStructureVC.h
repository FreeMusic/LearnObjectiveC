//
//  BaseDataStructureVC.h
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/30.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "BaseViewController.h"

typedef int ElemType;//int类型的数据

typedef NS_ENUM(NSUInteger, Status) {
    
    ERROR = 0,//失败或者报错
    SUCCESS = 1,//成功
    
};

NS_ASSUME_NONNULL_BEGIN

@interface BaseDataStructureVC : BaseViewController

@end

NS_ASSUME_NONNULL_END
