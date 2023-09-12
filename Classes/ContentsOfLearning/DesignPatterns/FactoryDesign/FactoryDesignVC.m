//
//  FactoryDesignVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/11.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "FactoryDesignVC.h"
#import "FactoryDesignVC+FactorA.h"
#import "FactoryDesignVC+FactorB.h"

@interface FactoryDesignVC ()

@property (nonatomic, copy) NSMutableArray *array;

@end

@implementation FactoryDesignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYLog(@"%@   %@", [self class] , [super class]);
    NSMutableArray *array= [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    [self runFactor];
//
//    self.array = [NSMutableArray arrayWithObject:@"213123"];
//    [self.array addObject:@"312234"];
}


@end
