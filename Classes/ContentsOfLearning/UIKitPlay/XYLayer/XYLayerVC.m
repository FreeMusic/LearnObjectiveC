//
//  XYLayerVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/11/7.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "XYLayerVC.h"
#import "MAOLayer.h"

@interface XYLayerVC ()

@end

@implementation XYLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"LaunchImage"].CGImage);
    self.view.layer.contentsScale = [UIScreen mainScreen].scale;
//    self.view.layer.contentsGravity = kCAGravityCenter;
    self.view.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    self.view.layer.borderWidth = 2;
    self.view.layer.borderColor = [UIColor yellowColor].CGColor;
    
    CALayer *player = [[CALayer alloc] init];
    player.frame = CGRectMake(20, 200, 50, 50);
    player.cornerRadius = 5;
//    player.anchorPoint = CGPointMake(1, 1);
    player.backgroundColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:player];
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    [self.view addSubview:colorView];
    colorView.layer.cornerRadius = 5;
    colorView.backgroundColor = [UIColor greenColor];
    
    [UIView animateWithDuration:10 animations:^{
        player.backgroundColor = [UIColor redColor].CGColor;
        colorView.backgroundColor = [UIColor redColor];
    }];
    
    MAOLayer *maoLayer = [MAOLayer layer];
    maoLayer.bounds = CGRectMake(50, 300, 100, 100);
//    maoLayer.position = CGPointMake(100, 100);
    [maoLayer setNeedsDisplay];
    [self.view.layer addSublayer:maoLayer];
    MAOLayer *layer =[MAOLayer layer];
    //设置层的宽高
    layer.bounds= CGRectMake(50, 300,100,100);
    //设置层的位置
    layer.position= CGPointMake(50,300);
    //开始绘制图层
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

@end
