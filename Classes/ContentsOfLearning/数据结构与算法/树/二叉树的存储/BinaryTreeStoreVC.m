//
//  BinaryTreeStoreVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/6/18.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 二叉树的存储也分为顺序存储和链式存储（二叉链表）
 1.顺序存储容易造成空间上的浪费。
 2.二叉树的每个结点最毒偶有两个孩子，所以为他设计一个数据域和两个指针域，这样的链表称为二叉链表。
 
 二叉树的遍历：是指从根结点出发，按照某种次序依次访问二叉树中的所有结点，使得每个结点被访问一次且近被访问一次。
 二叉树的遍历方法：
 1.前序遍历：规则是若二叉树为空，则空操作返回，否则先访问根结点，然后前序遍历左子树，再前序遍历右子树。
 2.中序遍历：规则是若树为空，则空操作返回，否则从根结点开始（注意并不是先访问根结点），中序遍历根结点的左子树，然后是访问根节点，最后中序遍历右子树。
 3.后序遍历：规则是若树为空，则空操作返回，否则从左到右先叶子后结点的方式遍历访问右子树，最后是访问根结点。
 4.层序遍历：规则是若树为空，则空操作返回，否则从树的第一层，也就是根结点开始访问，从上而下逐层遍历，在同一层中，按从左到右的顺序对结点逐个访问。
 */

#import "BinaryTreeStoreVC.h"

typedef char CharElemType;
CharElemType none = ' ';//字符型以空格符为空
/**
二叉树的二叉链表结点的结构定义
 */
typedef struct BiTNode{//结点结构
    
    CharElemType data;//结点数据
    struct BiTNode *leftChild, *rightChild;//左右孩子指针
    struct BiTNode *parrent;//指向父结点的指针
    
}BiTNode, *BiTree;



#define MaxSize 100
typedef char String[MaxSize+1];//0号单元存放串的长度
String str;

int myIndex = 1;

@interface BinaryTreeStoreVC ()

@end

@implementation BinaryTreeStoreVC



- (void)viewDidLoad {
    [super viewDidLoad];

    int i;
    BiTree tree;
    CharElemType elem;
    //二叉树的初始化
    initBiTree(&tree);
    stringAssign(str, "ABDH#K###E##CFI###G#J##");//#表示空
    //二叉树的创建赋值
    CreateBiTree(&tree);
    //二叉树的前置遍历
//    PreOrderTraverse(tree);
}

/**
 二叉树的初始化

 @param tree 二叉树
 */
void initBiTree(BiTree *tree)
{
    *tree = NULL;
}

/**
 生成一个其值等于chars的串T

 @param T 串T
 @param chars char数组
 @return 成功或失败
 */
Status stringAssign(String T, char *chars)
{
    int i;
    
    if (strlen(chars) > MaxSize) {
        return ERROR;
    }else{
        T[0] = strlen(chars);//长度
        for (i = 1; i < T[0]; i++) {
            T[i] = *(chars+i-1);
        }
        
        return SUCCESS;
    }
}

/**
 构造二叉树

 @param tree 二叉树
 */
void CreateBiTree(BiTree *tree)
{
    CharElemType elem;
    elem = str[myIndex++];
    
    if (!*tree) {
        *tree = (BiTree)malloc(sizeof(BiTNode));//初始化
    }
//    RYQLog(@"%@", *tree);
//    if (elem == '#') {
//        *tree = NULL;
//    }else{
    
        if (!*tree) {
            exit(OVERFLOW);
        }else{
            (*tree)->data = elem;
            CreateBiTree(&(*tree) -> leftChild);
            CreateBiTree(&(*tree) -> rightChild);
        }
//    }
}

/**
 二叉树的前置遍历

 @param tree 二叉树
 */
void PreOrderTraverse (BiTree tree)
{
    if (tree == NULL) {
        return;
    }
    RYQLog(@" %c ", tree->data);//显示结点数据，可以更改为对其他结点的操作
    PreOrderTraverse(tree->leftChild);//先遍历左子树
    PreOrderTraverse(tree->rightChild);//再遍历右子树
}

@end
