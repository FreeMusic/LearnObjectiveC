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

@end

@implementation FigureOutLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
//    imageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
//    [self.view addSubview:imageView];
//    imageView.center = self.view.center;
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.maidingying.com/EcRtFuGLRaaF2zWWnViY6g=="] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSData *data = UIImageJPEGRepresentation(image, 0);
//        imageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
//    }];
////    dispatch_async(dispatch_get_global_queue(0, 0), ^{
////       image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img.maidingying.com/EcRtFuGLRaaF2zWWnViY6g=="]]];
////        dispatch_async(dispatch_get_main_queue(), ^{
////
////            imageView.animatedImage = image;
////        });
////
////    });
    
    FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc] init];
    [self.view addSubview:imgView];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    imgView.layer.masksToBounds = YES;
    imgView.frame = CGRectMake(0, 0, 100, 100);
    imgView.center = self.view.center;
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"http://img.maidingying.com/EcRtFuGLRaaF2zWWnViY6g=="]];
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
