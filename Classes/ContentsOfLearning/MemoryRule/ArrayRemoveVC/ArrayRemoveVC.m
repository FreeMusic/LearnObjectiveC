//
//  ArrayRemoveVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/11.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "ArrayRemoveVC.h"

@interface ArrayRemoveVC ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *Names;

@end

@implementation ArrayRemoveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.name = @"name";
    [self.Names addObject:self.name];
    
    [self.Names removeAllObjects];
    RYQLog(@"%@", self.name);
    RYQLog(@"%@", self.Names);
}

/**
 Names
 */
- (NSMutableArray *)Names{
    if(!_Names){
        _Names = [NSMutableArray array];
    }
    return _Names;
}

- (void)dealloc {
    RYQLog(@"%@", self.name);
}

@end
