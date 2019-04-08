//
//  MainStructureVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/4/8.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "MainStructureVC.h"

#define MAXSIZE 20

typedef int ElemType;

struct Node {
    ElemType data;
    struct Node *next;
};

typedef NS_ENUM(int ,Status) {
    StatusError,
    StatusSuccess,
    StatusUnKnown,
};

typedef struct Node *LinkList;

@interface MainStructureVC ()

@end

@implementation MainStructureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      
                      ];
}

void CreateListHead (LinkList *l, int n)
{
    
}


Status GetElem (LinkList list, int i, ElemType *elem)
{
    int j = 0;
    LinkList p = list->next;
    j = 1;
    
    while (p && j < i) {
        p = p->next;
        
        ++j;
    }
    
    if ( !p || j > i) return StatusError;
    
    *elem = p->data;
    
    return StatusSuccess;
}

@end
