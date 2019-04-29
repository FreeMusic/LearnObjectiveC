//
//  DefineLinearTableVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/9.
//  Copyright © 2019 橘子. All rights reserved.
//  线性表：零个或多个数据元素的有限序列 （元素之间是有序的，若元素存在多个，则第一个元素无前驱，最后一个元素无后继。线性表是有限的）
//线性表的个数定义为线性表的长度 个数为0即是空表
//在复杂的线性表中，一个数据元素可以由若干个数据项组成
//线性表的顺序存储结构 指的是用一段地址连续的存储单元依次存储线性表的数据元素。

#import "DefineLinearTableVC.h"

static const BOOL ILoveYY = YES;

static const int distanceFuture = 21900;

@interface DefineLinearTableVC ()

@property (nonatomic, assign) int love;

@end

@implementation DefineLinearTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _love = 1;
    
    if (ILoveYY) {
        
        DefineLinearTableVC *sunXianSheng = [DefineLinearTableVC new];
        
        [sunXianSheng wantHaveAlongLastingLoveWithYou];
        
    }
}

- (void)wantHaveAlongLastingLoveWithYou{
    
    int ourBegin = 1;
    
    while (ourBegin < distanceFuture) {
        ourBegin++;
        _love = _love*2+ourBegin;
    }
    
}

@end
