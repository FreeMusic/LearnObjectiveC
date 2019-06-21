//
//  CluesBinaryTreeVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/6/21.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 线索二叉树
 普通的二叉树指针域并不能充分的被利用，对于一个有n个结点的二叉链表，每个结点会有2n个指针域。而n个结点的二叉树一共有n-1条分支线，也就是存在n+1个空指针域。另一方面，在二叉链表上并不能知道该结点的前驱和后继，需要对二叉链表遍历一次。
 
 指向前驱和后继的指针统称为线索，加上线索的二叉链表称为线索链表，相应的二叉树称为线索二叉树。
 我们对二叉树以某种次序遍历使其变为线索二叉树的过程称为线索化。
 线索化的过程也就是在遍历的过程中修改空指针的过程。
 */

#import "CluesBinaryTreeVC.h"

@interface CluesBinaryTreeVC ()

@end

@implementation CluesBinaryTreeVC



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


@end
