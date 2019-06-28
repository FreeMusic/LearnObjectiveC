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
#define MAXSIZE 100

typedef char CluesElemType;

typedef char CluesString[24];
CluesString myString;
int cluesIndex = 1;

typedef enum {
    Link,
    Thread
} PointerTag;//Link==0表示指向左右孩子的指针

typedef struct BiThreadNode{
    CluesElemType data;//结点数据
    struct BiThreadNode *leftChild, *rightChild;//左右孩子
    PointerTag leftTag;
    PointerTag rightTag;//左右标志
}BiThreadNode, *BiThreadTree;

CluesElemType NIL = '#';//字符以#为空
BiThreadTree preHeader;//全局变量 始终指向刚刚访问的结点

@interface CluesBinaryTreeVC ()

@end

@implementation CluesBinaryTreeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    BiThreadTree H, T;
    cluesStringAssign(myString, "ABDH##I##EJ###CF##G##");
    CreateBiThreadTree(&T);//按照前序产生二叉树
    inOrderThreadingHead(&H, T);
    inOrderTravelalThreading(H);
}

/**
 遍历结点

 @param elem 结点元素
 */
Status visit(CluesElemType elem)
{
    RYQLog(@"%c", elem);
    return SUCCESS;
}
/**
 将字符分开一个个放在数组中

 @param T 字符数组
 @param chars 字符串
 @return 结果
 */
Status cluesStringAssign(CluesString T, char *chars)
{
    if (strlen(chars) > MAXSIZE) {
        return ERROR;
    }else{
        T[0] = strlen(chars);
        for (int i = 1; i <= T[0]; i++) {
            T[i] = *(chars+i-1);
        }
    }
    return SUCCESS;
}

/**
 创建线索二叉树 前序创建方式

 @param tree 线索二叉树
 @return Status
 */
Status CreateBiThreadTree(BiThreadTree *tree)
{
    CluesElemType elem = myString[cluesIndex++];
    if (elem == NIL) {
        *tree = NULL;
    }else{
        *tree = (BiThreadTree)malloc(sizeof(BiThreadNode));
        if (!*tree) {
            exit(OVERFLOW);
        }else{
            (*tree)->data = elem;//生成根结点
            CreateBiThreadTree(&(*tree)->leftChild);//递归构造左子树
            if ((*tree)->leftChild) {//有左孩子
                (*tree)->leftTag = Link;
            }
            CreateBiThreadTree(&(*tree)->rightChild);//递归构造右子树
            if ((*tree)->rightChild) {//有右孩子
                (*tree)->rightTag = Link;
            }
        }
    }

    return SUCCESS;
}

/**
 中序遍历线索化二叉树

 @param tree 线索二叉树
 */
void inOrderThreading(BiThreadTree tree)
{
    if (tree) {
        inOrderThreading(tree->leftChild);//递归左子树的线索化
        if (!tree->leftChild) {//没有左孩子
            tree->leftTag = Thread;//前驱线索
            tree->leftChild = preHeader;//左孩子指针指向前驱
        }
        if (!preHeader->rightChild) {//前驱没有右孩子
            preHeader->rightTag = Thread;//后继线索
            preHeader->rightChild = tree;//后继右孩子指针指向后继 当前结点 tree
        }
        
        preHeader = tree;//保持preHeader指向tree的前驱
        inOrderThreading(tree->rightChild);//保持右子树线索化
    }
}

/**
 中序遍历二叉树tree，并将其中序线索化，threadTree指向头结点

 @param threadTree threadTree指向头结点
 @param tree 二叉树tree
 */
void inOrderThreadingHead(BiThreadTree *threadTree, BiThreadTree tree)
{
    *threadTree = (BiThreadTree)malloc(sizeof(BiThreadNode));

    if (!*threadTree) {
        exit(OVERFLOW);
    }
    (*threadTree)->leftTag = Link;//建立头结点
    (*threadTree)->rightTag = Thread;
    (*threadTree)->rightChild = (*threadTree);//右指针回指
    if (!tree) {//若二叉树为空，则左指针回指
        (*threadTree)->leftChild = (*threadTree);
    }else{
        (*threadTree)->leftChild = tree;
        preHeader = (*threadTree);
        inOrderThreading(tree);//中序遍历 进行中序线索化
        preHeader->rightChild = *threadTree;
        preHeader->rightTag = Thread;//最后一个结点进行线索化
        (*threadTree)->rightChild = preHeader;
    }
}

/**
 中序遍历二叉线索表

 @param tree 二叉线索表
 @return    是否成功
 */
Status inOrderTravelalThreading(BiThreadTree tree)
{
    BiThreadTree p = tree->leftChild;//p指针指向根结点
    while(p != tree)//空树或遍历结束时， p==tree
    {
        while(p->leftTag==Link)
        {
            p=p->leftChild;
        }
        RYQLog(@"p->data = %c", p->data);//访问前驱结点
        while(p->rightTag==Thread&&p->rightChild!=tree)
        {
            p=p->rightChild;
            RYQLog(@"p->data = %c", p->data);//访问后继结点
        }
        p=p->rightChild;
    }
    return SUCCESS;
}

@end
