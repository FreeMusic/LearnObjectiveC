//
//  TransitionAnimationVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/11/3.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "TransitionAnimationVC.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LXYImageBrowserManger.h"

@interface TransitionAnimationVC ()

@property (nonatomic, strong) LXYImageBrowserManger *imageBrowserManger;///

@end

@implementation TransitionAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    [scrollView setContentSize:CGSizeMake(0, 1200)];
    
    CGFloat W = (kScreenWidth-20-10)/3;
#warning 有时候图片的链接地址会无效，更换为有效的链接地址即可
    NSArray * images = @[@"http://img01.cztv.com/201508/19/9008d57f59984e7b188ab69fbb458915.jpg",@"http://img2.100bt.com/upload/ttq/20140315/1394865797382_middle.jpeg",@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1301/23/c0/17652199_1358923371562.jpg",@"https://b-ssl.duitang.com/uploads/item/201508/25/20150825230502_2nPUC.thumb.700_0.jpeg"];
    NSInteger count = (images.count)%3?(images.count/3+1):images.count/3;
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(10, 200, kScreenWidth-20, count*W + (count-1)*5)];
    [scrollView addSubview:backView];
    backView.backgroundColor = [UIColor grayColor];
    NSMutableArray * originImageViews = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < images.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%3)*(W+5), i/3*(W+5), W, W)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:images[i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [backView addSubview:imageView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouchAction:)];
        [imageView addGestureRecognizer:tap];
        [originImageViews addObject:imageView];
    }
    
#warning 有时候图片的链接地址会无效，更换为有效的链接地址即可
    NSArray * bigImages = @[@"http://img01.cztv.com/201508/19/9008d57f59984e7b188ab69fbb458915.jpg",@"http://img2.100bt.com/upload/ttq/20140315/1394865797382_middle.jpeg",@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1301/23/c0/17652199_1358923371562.jpg",@"https://b-ssl.duitang.com/uploads/item/201508/25/20150825230502_2nPUC.thumb.700_0.jpeg"];
    //初始化 manger
    LXYImageBrowserManger *imageBrowserManger = [LXYImageBrowserManger imageBrowserMangerWithUrlStr:bigImages originImageViews:originImageViews originController:self];

    _imageBrowserManger = imageBrowserManger;
}

- (void)imageTouchAction:(UIGestureRecognizer *)ges {
    //点击了的某一个 imageView
    _imageBrowserManger.selectPage = ges.view.tag;
    [_imageBrowserManger showImageBrowser];
}


@end
