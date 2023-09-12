//
//  KVO_VC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

/**
 1.KVC是基于runtime机制实现的
 
 2、可以访问私有成员变量、可以间接修改私有变量的值
 
 KVC键值查找原理:
 ************************setValue:forKey:搜索方式****************************
 
 1、首先搜索setKey:方法.(key指成员变量名, 首字母大写)
 2、上面的setter方法没找到, 如果类方法accessInstanceVariablesDirectly返回YES. 那么按 _key, _isKey，key, iskey的顺序搜索成员名。(这个类方法是NSKeyValueCodingCatogery中实现的类方法, 默认实现为返回YES)
 3、如果没有找到成员变量, 调用setValue:forUnderfinedKey:
 
************************valueForKey:的搜索方式****************************
 
 1、首先按getKey, key, isKey的顺序查找getter方法, 找到直接调用. 如果是BOOL、int等内建值类型, 会做NSNumber的转换.
 2、上面的getter没找到, 查找countOfKey, objectInKeyAtindex, KeyAtindexes格式的方法. 如果countOfKey和另外两个方法中的一个找到, 那么就会返回一个可以响应NSArray所有方法的代理集合的NSArray消息方法.
 3、还没找到, 查找countOfKey, enumeratorOfKey, memberOfKey格式的方法. 如果这三个方法都找到, 那么就返回一个可以响应NSSet所有方法的代理集合.
 4、还是没找到, 如果类方法accessInstanceVariablesDirectly返回YES. 那么按 _key, _isKey, key, iskey的顺序搜索成员名.
 5、再没找到, 调用valueForUndefinedKey.
 */

#import "KVC_VC.h"
#import "KVC_Model.h"

@interface KVC_VC ()

@property (nonatomic, strong) KVC_Model *model;

@end

@implementation KVC_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //键值编码 KVC修改私有变量
    [self KeyValueCodingChangePrivacyObject];
}

/**
 键值编码 KVC修改私有变量
 就会被编译器处理成:
 // 首先找到对应sel
 SEL sel = sel_get_uid("setValue:forKey:");
 // 根据object->isa找到sel对应的IMP实现指针
 IMP method = objc_msg_lookup (object->isa,sel);
 // 调用指针完成KVC赋值
 method(object, sel, @"134567", @"uid");
 */
- (void)KeyValueCodingChangePrivacyObject{
    //KVC访问私有变量
    self.model = [[KVC_Model alloc] init];
    XYLog(@"%@    %@", self.model.name, [self.model valueForKey:@"privacy"]);
    //KVC修改私有变量
    [self.model setValue:@"KVC修改私有变量" forKey:@"privacy"];
    XYLog(@"%@    %@", self.model.name, [self.model valueForKey:@"privacy"]);
}

- (void)dealloc {
    
    XYLog(@"dealloc");
    
}

@end
