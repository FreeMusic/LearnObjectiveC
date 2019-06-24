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

@interface CluesBinaryTreeVC ()

@end

@implementation CluesBinaryTreeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    BiThreadTree HTree, TTree;
    cluesStringAssign(myString, "ABDH#K###E##CFI###G#J##");
    CreateBiThreadTree(&TTree);//按照前序产生二叉树
}

/**
 遍历结点

 @param elem 结点元素
 */
void visit(CluesElemType elem)
{
    RYQLog(@"%c", elem);
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

@end
