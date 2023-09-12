//
//  StackVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/21.
//  Copyright © 2019 橘子. All rights reserved.
//  栈此处介绍栈的链式存储结构，至于顺序存储结构，跟线性表类似。个人认为弊端太多。
//  栈是线性表，只能在表尾进行插入删除操作

#import "StackVC.h"


/**
 栈的数据结构
 */
typedef struct StackNode{
    ElemType data;//数据域
    struct StackNode *next;//指针域
}StackNode, *LinkStackChained;

typedef struct LinkStack{
    LinkStackChained top;//指向栈顶的指针
    int count;//栈个数
}LinkStack;

@interface StackVC ()

@end

@implementation StackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LinkStack stack;
    initStack(&stack);
    stackPush(&stack, 200);
//    stackPop(&stack);
//    stackPopToIndex(&stack, 4);
    stackPopToElem(&stack, 60);
    cleanStack(&stack);
    initStack(&stack);
    travelStack(&stack);
}

Status initStack(LinkStack *stack)
{
    stack->top = NULL;
    for (int i = 1; i < 11; i++) {
        stackPush(stack, i*10);
    }
    
    return SUCCESS;
}

void travelStack(LinkStack *stack)
{
    //空栈抛异常
    if (stackIsEmpty(stack)) {
        return;
    }
    int index = stack->count;
    LinkStackChained elem = stack->top;
    while (index > 0) {
        XYLog(@"elem->data = %d", elem->data);
        elem = elem->next;
        index--;
    }
}

/**
 栈的push操作

 @param stack 栈
 @param data 数据
 @return 结果
 */
Status stackPush(LinkStack *stack, ElemType data)
{
    LinkStackChained elem = (LinkStackChained)malloc(sizeof(StackNode));
    elem->data = data;//创建一个元素，并赋值
    elem->next = stack->top;//新元素的后置指针指向栈顶，即将新元素放在栈顶
    stack->top = elem;//此时新元素在栈的最顶端，那么栈顶指针也要指向新加入的元素
    stack->count++;//栈中元素个数累加
    
    return SUCCESS;
}

/**
 栈的pop操作

 @param stack 栈
 @return 结果
 */
Status stackPop(LinkStack *stack)
{
    //空栈抛异常
    if (stackIsEmpty(stack)) {
        return ERROR;
    }
    
    LinkStackChained elem = stack->top;//取出栈顶元素
    stack->top = elem->next;//栈顶指针重新指向
    stack->count--;//栈中元素个数减一
    free(elem);//释放元素
    
    return SUCCESS;
}

/**
 栈返回到指定元素

 @param stack 栈
 @param data 元素数据
 @return 结果
 */
Status stackPopToElem(LinkStack *stack, ElemType data)
{
    int index = checkElemExitStack(stack, data);
    
    if (index == 0) {
        return ERROR;
    }
    //栈返回到指定的下标处
    stackPopToIndex(stack, index);
    
    
    return SUCCESS;
}

/**
 检测元素在栈中是否存在

 @param stack 栈
 @param data 数据
 @return 结果
 */
int checkElemExitStack(LinkStack *stack, ElemType data)
{
    
    //空栈抛异常
    if (stackIsEmpty(stack)) {
        return ERROR;
    }
    LinkStackChained elem = stack->top;//取出栈顶元素
    int index = stack->count;
    while (elem->data != data) {
        elem = elem->next;
        index--;
        
        if (index == 0) {
            return 0;
        }
    }
    
    return index;
}

/**
栈返回到指定的下标处

 @param stack 栈
 @param index 下标
 @return 结果
 */
Status stackPopToIndex(LinkStack *stack, int index)
{
    if (index > stack->count) {
        return ERROR;
    }
    
    while (index < stack->count) {
        //栈的pop操作
        stackPop(stack);
    }
    
    return SUCCESS;
}

/**
 判断栈是否为空

 @param stack 栈
 @return 结果
 */
bool stackIsEmpty(LinkStack *stack)
{
    return (stack->count == 0);
}

/**
 清空栈

 @param stack 栈
 */
void cleanStack(LinkStack *stack)
{
    
    if (stackIsEmpty(stack)) {
        return;
    }
    
    LinkStackChained p,q;
    p = stack->top;//栈顶元素
    
    while (p) {
        q = p;
        p = p->next;
        free(q);
    }
    free(p);
    stack->count = 0;
}














/**
 递归运算  选择结构 递归能使程序的结构清晰，但是放大量的递归调用会建立函数的副本，耗费大量的时间和内存

 @param i num
 @return result
 */
int YQNumber (int i)
{
    if (i < 2) {
        return i == 0 ? 0 : 1;
    }
    
    return YQNumber(i-1) + YQNumber(i-2);
}

/**
 迭代运算 循环结构 不需要额外的内存
 */
int forCycle(int max)
{
    if (max < 2) {
        return 0;
    }
    
    int array[max];
    array[0] = 0;
    array[1] = 1;

    int sum = array[1];
    for (int i = 2; i <= max; i++) {
        
        array[i] = array[i-1] + array[i-2];
        sum = array[i];
    }
    
    return sum;
}


@end
