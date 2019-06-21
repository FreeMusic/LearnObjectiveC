//
//  MainTreeVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/6/4.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 树是n(n>=0)个结点的有限集。n=0时称为空树。
 在任意一排非空树中：
 1.有且仅有一个特定的称为根的结点。
 2.当n>1时，其余结点可分为m(m>0)个互不相交的有限集T1,T2...Tm,其中每个集合的本身又是一棵树，并且称为根的子树。
 
 结点拥有的子树称为结点的度。度为0的结点称为叶结点或终端结点；
 度不为0的结点称为非终端结点或分支结点。
 除根结点外，分支结点也称为内部结点。
 树的度是树内各结点的度的最大值。
 */

#import "MainTreeVC.h"

@interface MainTreeVC ()

@end

@implementation MainTreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.Messages = @[
                    [ObjectiveModel initTitle:@"二叉树的定义" vcName:@"BinaryTreeDefineVC"],
                    [ObjectiveModel initTitle:@"二叉树的存储" vcName:@"BinaryTreeStoreVC"],
                    [ObjectiveModel initTitle:@"线索二叉树" vcName:@"CluesBinaryTreeVC"],
                      ];
}


@end
