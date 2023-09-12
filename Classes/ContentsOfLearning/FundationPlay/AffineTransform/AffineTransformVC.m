//
//  AffineTransformVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/9/12.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "AffineTransformVC.h"

@interface AffineTransformVC ()

@property (nonatomic, strong) UIView *cgView;//

@end

CGFloat length = 100;

@implementation AffineTransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ///
    NSArray *dataSource = @[
        @"移动视图", @"旋转视图", @"缩放视图", @"组合视图"
    ];
    CGFloat width = 50; CGFloat height = 20; CGFloat space = 10;
    for (int i = 0; i < dataSource.count; i++) {
        NSString *title = dataSource[i];
        UIButton *button = [UIButton ButtonWithTitle:title ButtonBackColor:ButtonNormalColor CornerRadius:5 addSubView:self.view buttonActionBlock:^(UIButton * _Nullable button) {
            
        }];
        button.frame = CGRectMake(space + (width + space) * i, 100, width, height);
    }
    self.cgView = [[UIView alloc] init]; self.cgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.cgView]; self.cgView.frame = CGRectMake(0, length + width + space, length, length);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:3 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(100, 0);
        CGAffineTransform rotate = CGAffineTransformMakeRotation(M_PI_2);
        CGAffineTransform scale = CGAffineTransformMakeScale(0.5, 0.5);
        self.cgView.transform = CGAffineTransformConcat(CGAffineTransformConcat(transform, rotate), scale);
    } completion:^(BOOL finished) {
        self.cgView.transform = CGAffineTransformIdentity;
    }];
}

@end
