//
//  BinaryTreeDefineVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/6/5.
//  Copyright © 2019 橘子. All rights reserved.
//  二叉树是n个结点的有限集合，该集合或者为空集（称为空二叉树），或者由一个根节点和两棵互不相交的、分别称为根结点的左子树和右子树的二叉树组成
/**
 二叉树的特点：
 每个结点最多有两棵子树，所以在二叉树中不存在度大于2的结点。注意不是只有两棵子树，而是最多有。没有子树或者只有一个子树也是可以的。
 左子树和右子树是有顺序的，次顺不能任意颠倒。类似人的左右手，左右脚等等。
 即使树中某结点只有一棵树，也要区分它是左子树还是右子树。
 
 
 二叉树的五种基本形态：
 1.空二叉树
 2.只有一个根结点
 3.根结点只有左子树
 4.根结点只有右子树
 5.根结点既有左子树又有右子树
 
 特殊的二叉树：
 1.斜树。分为左斜树和右斜树
 2.满二叉树。分支结点均存在左子树右子树。
 3.完全二叉树：对于一颗具有n个结点的二叉树按层序排号，如果编号为i（1 <= i <= n）的结点与同样深度的满二叉树中编号为i的结点在二叉树中位置完全相同，则这棵树称为完全二叉树。   简单的说，一个二叉树中，除终端节点外，其他结点必有左子树。才称得上完全二叉树。  满二叉树一定是完美二叉树
 */
#import "BinaryTreeDefineVC.h"

#define MaxSize 100

typedef char CharElemType;

typedef struct YQBiNode {
    CharElemType data;
    struct YQBiNode *leftChild, *rightChild;
}YQBiNode, *YQBiTree;

typedef char YQString[MaxSize];
YQString mystr;

int elemIndex = 1;

@interface BinaryTreeDefineVC ()

@end

@implementation BinaryTreeDefineVC

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    YQBiTree tree;
    initTestTree(&tree);
    stringAssignArray(mystr, "ABDH#K###E##CFI###G#J##");
    CreateYQBiTree(&tree);
    preOrderTravel(tree);
    inOrderTravel(tree);
    postOrderTravel(tree);
}

void initTestTree(YQBiTree *tree)
{
    *tree = NULL;
}

void stringAssignArray(YQString T, char *chars)
{
    if (strlen(chars) > MaxSize) {
        return;
    }
    T[0] = strlen(chars);
    for (int i = 1; i <= T[0]; i++) {
        T[i] = *(chars+i-1);
    }
}

void CreateYQBiTree(YQBiTree *tree)
{
    CharElemType elem = mystr[elemIndex++];
    if (elem == '#') {
        *tree = NULL;
    }else{
        
        *tree = (YQBiTree)malloc(sizeof(YQBiNode));
        if (!*tree) {
            return;
        }else{
            (*tree)->data = elem;
            CreateYQBiTree(&(*tree)->leftChild);
            CreateYQBiTree(&(*tree)->rightChild);
        }
    }
}

void preOrderTravel(YQBiTree tree)
{
    if (tree == NULL) {
        return;
    }
    
    RYQLog(@"preOrderTravel %c", tree->data);
    preOrderTravel(tree->leftChild);
    preOrderTravel(tree->rightChild);
}

void inOrderTravel(YQBiTree tree)
{
    if (tree == NULL) {
        return;
    }
    inOrderTravel(tree->leftChild);
    RYQLog(@"inOrderTravel %c", tree->data);
    inOrderTravel(tree->rightChild);
}

void postOrderTravel(YQBiTree tree)
{
    if (tree == NULL) {
        return;
    }
    postOrderTravel(tree->leftChild);
    postOrderTravel(tree->rightChild);
    RYQLog(@"postOrderTravel %c", tree->data);
}

@end
