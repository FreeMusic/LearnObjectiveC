//
//  FigureOutLayoutVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "FigureOutLayoutVC.h"
#import "LayOutCell.h"
#import "UIImage+GIF.h"
#import "FLAnimatedImage.h"

@interface FigureOutLayoutVC ()

@property (nonatomic, copy) NSString *name;

@end

@implementation FigureOutLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIView animateWithDuration:1 animations:^{
        self.name = @"12323";
    }];
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        RYQLog(@"线程死锁");
//    });
    
//    FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc] init];
//    [self.view addSubview:imgView];
//    imgView.contentMode = UIViewContentModeScaleAspectFill;
//    imgView.layer.masksToBounds = YES;
//    imgView.frame = CGRectMake(0, 0, 100, 100);
//    imgView.center = self.view.center;
//    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.maidingying.com/EcRtFuGLRaaF2zWWnViY6g=="]];
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth, 400*m6Scale);
//    self.collectionView.center = self.view.center;
//    self.collectionView.pagingEnabled = YES;
//    [self.collectionView registerClass:[LayOutCell class] forCellWithReuseIdentifier:@"LayOutCell"];
}

//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 10;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    LayOutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LayOutCell" forIndexPath:indexPath];
//    [cell zoomCardView];
//
//    return cell;
//}
//
///**
// 设置item的大小
// */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return CGSizeMake(kScreenWidth, 400*m6Scale);
//}

@end
