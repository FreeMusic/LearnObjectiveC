//
//  KMPMatchVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 子串的定位操作通常称作串的模式匹配
 */
#import "KMPMatchVC.h"

#define MaxSize 100


typedef char String[MaxSize+1];//0号单元存放串的长度

@interface KMPMatchVC ()


@end

@implementation KMPMatchVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    String s1, s2;
    initString(s1, "goodchina");
    initString(s2, "china");
//    StringPrint(s1);
    //朴素匹配法
//    int index = Index(s1, s2);
//    RYQLog(@"index = %d", index);
    //
    int kmp_index = KMP_Index(s1, s2);
    RYQLog(@"kmp_index = %d", kmp_index);
}

/**
 生成一个其值等于chars的串T
 */
void initString(String T, char *chars)
{
    if (strlen(chars) > MaxSize) {
        return;
    }else{
        T[0] = strlen(chars);
        for (int i = 1; i <= T[0]; i++) {
            T[i] = *(chars+i-1);
        }
    }
}

void StringPrint(String T)
{
    for (int i = 1; i <= T[0]; i++) {
        RYQLog(@"%c\n", T[i]);
    }
}

/**
 清空

 @param S 清空
 */
void cleanString(String S)
{
    S[0] = 0;//长度为0；
}

/**
 串元素的个数

 @param S 串
 @return 个数
 */
int stringLength(String S)
{
    return S[0];
}

/**
 朴素模式的匹配算法

 @param S 主串
 @param T 子串
 @return 子串在主串中的位置
 */
int Index(String S, String T)
{
    int i = 1;//i用于主串S中当前位置下标值，若pos不为1，则从pos位置开始匹配。
    int j = 1;//j用于子串T中当前位置下标值
    while (i <= S[0] && j <=T[0])
    {//若i小于S的长度并且j小于T的长度时，循环继续
        if (S[i] == T[j]) {//两字符相等
            i++;
            j++;
        }else{//指针后退 重新开始匹配
            i = i-j+2;//i退回到上次匹配首位的下一位
            j = 1;//j退回到子串T的首位
        }
    }
    
    if (j > T[0]) {
        return i-T[0];
    }
    
    return 0;
}
/**
 KMP模式匹配法

 @param S 主串
 @param T 子串
 @return 子串在主串中的位置
 */
int KMP_Index(String S, String T)
{
    int i = 1;//i用于主串S下当前的标注
    int j = 1;//用于子串T中当前位置下的标注
    
    int next[100];//定义next数组
    Get_Next(T, next);//获取next数组
    
    while (i <= S[0] && j <= T[0]) {//若i小于S的长度且j小于T的长度时，循环继续
        
        if (j == 0 || S[i] == T[j]) {//与朴素算法相比，增加了j == 0
            ++i;
            ++j;
        }else{
            //指针后退重新开始匹配
            j = next[j];//j返回到何时的位置，i值不变
        }
        
    }
    
    if (j > T[0]) {
        return i-T[0];
    }

    return 0;
}

/**
 返回T串next数组

 @param T T串
 */
void Get_Next(String T, int *next)
{

    int i,j;
    i = 1;
    j = 0;
    next[1] = 0;
    while (i < T[0]) {//T[0]是串T的长度

        if (j == 0 || T[i] == T[j]) {//T[i]表示后缀的单个字符， T[j]表示前缀的单个字符

            ++i;
            ++j;
            
            if (T[i] != T[j]) {//T[i]表示后缀的单个字符，T[j]表示前缀的单个字符
                next[i] = j;//则当前的j为next在i位置的值
            }else{
                next[i] = next[j];//如果与前缀字符相同，则将前缀字符的next赋值给next在i位置的值
            }
            
            next[i] = j;
        }else{

            j = next[j];//若字符串不相同，则j值回溯
        }

    }
}

@end
