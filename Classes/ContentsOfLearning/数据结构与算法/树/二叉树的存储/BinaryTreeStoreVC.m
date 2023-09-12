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

#define MAXSIZE 100
int ourIndex = 1;//用于构造二叉树

typedef char String[MAXSIZE];//0号位置存放串的长度
String string;

typedef char CharElemType;//数据类型
CharElemType none = ' ';//用空格表示空

/**
 二叉树的结点结构
 */
typedef struct BiTNode{
    CharElemType data;//数据项
    struct BiTNode *leftChild, *rightChild;//左右孩子
    struct BiTNode *parrent;//父结点
}BiTNode, *BiTree;

@interface BinaryTreeStoreVC ()

@end

@implementation BinaryTreeStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    BiTree tree;
    //构造空的二叉树
    initTree(&tree);
    //将字符分开一个个放在数组中
    stringAssign(string, "ABDH#K###E##CFI###G#J##");
    //二叉树的赋值
    CreateOurBiTree(&tree);
    
    //二叉树的前序遍历
    BiTreePreorderTraverse(tree);
    //二叉树的中序遍历
    BiTreeInorderTraverse(tree);
    //二叉树的后序遍历
    BiTreePostOrderTraverse(tree);
}

/**
 构造空的二叉树

 @param tree 二叉树
 */
void initTree(BiTree *tree)
{
    *tree = NULL;
}

/**
 将字符分开一个个放在数组中

 @param T 字符数组
 @param chars 字符串
 @return 结果
 */
Status stringAssign(String T, char *chars)
{
    int i;
    if (strlen(chars) > MAXSIZE) {
        return ERROR;
    }else{
        T[0] = strlen(chars);
        for (i = 1; i <= T[0]; i++){
            T[i] = *(chars+i-1);
        }
        return SUCCESS;
    }
}

/**
 二叉树的赋值  前序遍历的方式

 @param tree 二叉树
 */
void CreateOurBiTree(BiTree *tree)
{
    CharElemType elem = string[ourIndex++];//从字符数组中挨个取出字符

    if (elem == '#') {//#表示空
        *tree = NULL;
    }else{
        *tree = (BiTree)malloc(sizeof(BiTNode));
        if (!*tree) {
            exit(OVERFLOW);
        }else{
            (*tree)->data = elem;//生成根结点
            CreateOurBiTree(&(*tree)->leftChild);//构造左子树
            CreateOurBiTree(&(*tree)->rightChild);//构造右子树
        }
    }
}

/**
 二叉树的前序遍历  先根结点 再次左子树 最后右子树

 @param tree 二叉树
 */
void BiTreePreorderTraverse(BiTree tree)
{
    if (tree == NULL) {
        return;
    }
    
    XYLog(@"二叉树的前序遍历  %c ", tree->data);//显示结点数据
    BiTreePreorderTraverse(tree->leftChild);//先遍历左子树
    BiTreePreorderTraverse(tree->rightChild);//再遍历右子树
}

/**
 二叉树的中序遍历  先左子树 再根结点 最后右子树

 @param tree 二叉树
 */
void BiTreeInorderTraverse(BiTree tree)
{
    if (tree == NULL) {
        return;
    }
    
    BiTreeInorderTraverse(tree->leftChild);
    XYLog(@"二叉树的中序遍历  %c ", tree->data);//显示结点数据
    BiTreeInorderTraverse(tree->rightChild);
}

/**
 二叉树的后序遍历  先左结点 后右结点 再根结点

 @param tree 二叉树
 */
void BiTreePostOrderTraverse(BiTree tree)
{
    if (tree == NULL) {
        return;
    }
    
    BiTreePostOrderTraverse(tree->leftChild);
    BiTreePostOrderTraverse(tree->rightChild);
    XYLog(@"二叉树的后序遍历  %c ", tree->data);//显示结点数据
}

@end
