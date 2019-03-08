//
//  BaseViewController.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy) NSArray *Messages;

@end

@interface ObjectiveModel: NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *vcName;


@property (nonatomic, strong) UIViewController *vc;//

/**
 @property (nonatomic, strong) UIViewController *myCopyVC;//
 并做跳转的时候 每次初始化的时候直接将控制器传过来即可，但是这种方法PUSH出来的页面 会出现PUSH的页面再返回的时候不执行dealloc方法。原因是该控制器在pop回来的时候并没有释放掉(ObjectiveModel类没有销毁， vc对象也不会销毁)，引用计数器为0的时候才会执行dealloc。
 */
/**
 1）不执行dealloc
 
 1.查看是不是循环引用造成的类不销毁
 
 2.调用其他类的时候查看有没有将本类中的对象传过去，例如self,self.tableview
 
 传的时候注意使用weak,不要使用strong
 
 否则会造成当前类无法释放，dealloc不执行一直占用内存。
 */


+ (ObjectiveModel *)initTitle:(NSString *)title vcName:(NSString *)vcName;

+ (ObjectiveModel *)initTitle:(NSString *)title vc:(UIViewController *)vc;

@end

