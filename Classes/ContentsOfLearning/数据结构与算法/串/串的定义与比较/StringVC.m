//
//  StringVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/5/27.
//  Copyright © 2019 橘子. All rights reserved.
//
/**
 串是由零个或多个字符组成的有限序列，又名叫字符串。序列说明串的相邻字符之间有前驱和后继的关系。
 串中任意个数的连续字符组成的子序列称为子串，包含子串的串称为主串
 串的比较其实是比较字符的编码 ASCII编码，7位二进制数表示一个字符 表示128个字符，因为特殊符号的而出现，128个不够用，扩展ASCII编码，8位二进制数表示一个字符，表示256个字符。再后来不够用增加了Unicode编码，16位的二进制数表示一个字符，为了和ASCII编码相容，Unicode前256个字符与ASCII码完全相同
 */

#import "StringVC.h"

@interface StringVC ()

@end

@implementation StringVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string = @"qqq23432qqqq";
    [self compareExample:string];
}


- (void)compareExample:(NSString *)string{
    if (string.length < 2) {
        return;
    }
    NSString *first = [string substringWithRange: NSMakeRange(0, 1)];;
    NSString *current = @"";
    for (int i = 1; i < string.length; i++) {
        
        NSRange range = NSMakeRange(i, 1);
        current = [string substringWithRange:range];
        if (![first isEqualToString:current]) {
            RYQLog(@"不同的字符 %@   位置 %d", current, i+1);
            break;
        }else{
            first = current;
        }
    }
    if ([first isEqualToString:current]) {
        RYQLog(@"该字符串中的字符完全一样");
        return;
    }
}


@end
