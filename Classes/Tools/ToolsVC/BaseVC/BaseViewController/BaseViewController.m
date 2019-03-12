//
//  BaseViewController.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate> //声明侧滑手势的delegate

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backGroundColor;
    //开启iOS7及以上的滑动返回效果
    //返回按钮自定义
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

//UIGestureRecognizerDelegate 重写侧滑协议

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    return [self gestureRecognizerShouldBegin];;
    
}

- (BOOL)gestureRecognizerShouldBegin {
    
    return YES;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //设置状态栏和导航栏字体的颜色为白色
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end


@interface ObjectiveModel ()

@end

@implementation ObjectiveModel

+ (ObjectiveModel *)initTitle:(NSString *)title vcName:(NSString *)vcName{
    
    ObjectiveModel *model = [ObjectiveModel new];
    model.title = title;
    model.vcName = vcName;
    
    return model;
}

+ (ObjectiveModel *)initTitle:(NSString *)title vc:(UIViewController *)vc{
    
    ObjectiveModel *model = [ObjectiveModel new];
    model.title = title;
    model.vc = vc;
    
    return model;
}

@end
