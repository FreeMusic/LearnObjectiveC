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
int ourIndex=1;

typedef char String[24]; /*  0∫≈µ•‘™¥Ê∑≈¥Æµƒ≥§∂» */
String string;

typedef char CharElemType;
CharElemType NIL=' '; /* ◊÷∑˚–Õ“‘ø’∏Ò∑˚Œ™ø’ */

typedef struct BiTNode  /* Ω·µ„Ω·ππ */
{
    CharElemType data;        /* Ω·µ„ ˝æ› */
    struct BiTNode *leftChild,*rightChild; /* ◊Û”“∫¢◊”÷∏’Î */
}BiTNode,*BiTree;

@interface BinaryTreeStoreVC ()

@end

@implementation BinaryTreeStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int i;
    BiTree T;
    CharElemType e1;
    InitBiTree(&T);
    
    
    StrAssign(string,"ABDH#K###E##CFI###G#J##");
    
    CreateOurBiTree(&T);
}

Status StrAssign(String T,char *chars)
{
    int i;
    if(strlen(chars)>MAXSIZE){
        return ERROR;
    }
    else
    {
        T[0]=strlen(chars);
        for(i=1;i<=T[0];i++)
            T[i]=*(chars+i-1);
        return SUCCESS;
    }
}
/* ************************************************ */

Status visit(CharElemType e)
{
    printf("%c ",e);
    return SUCCESS;
}

/* ππ‘Ïø’∂˛≤Ê ˜T */
Status InitBiTree(BiTree *tree)
{
    *tree=NULL;
    return SUCCESS;
}

/* ∞¥«∞–Ú ‰»Î∂˛≤Ê ˜÷–Ω·µ„µƒ÷µ£®“ª∏ˆ◊÷∑˚£© */
/* #±Ì æø’ ˜£¨ππ‘Ï∂˛≤Ê¡¥±Ì±Ì æ∂˛≤Ê ˜T°£ */
void CreateOurBiTree(BiTree *tree)
{
    CharElemType elem;
    
    /* scanf("%c",&ch); */
    elem=string[ourIndex++];
    
    if(elem=='#'){
        *tree=NULL;
    }
    else
    {
        *tree=(BiTree)malloc(sizeof(BiTNode));
        if(!*tree){
            exit(OVERFLOW);
        }
        (*tree)->data=elem; /* …˙≥…∏˘Ω·µ„ */
        CreateOurBiTree(&(*tree)->leftChild); /* ππ‘Ï◊Û◊” ˜ */
        CreateOurBiTree(&(*tree)->rightChild); /* ππ‘Ï”“◊” ˜ */
    }
}



@end
