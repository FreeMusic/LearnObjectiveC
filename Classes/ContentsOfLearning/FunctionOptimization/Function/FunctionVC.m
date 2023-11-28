//
//  FunctionVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/13.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "FunctionVC.h"
#import "LZYPWebViewVC.h"
#import <Photos/Photos.h>

@interface FunctionVC ()

@end

@implementation FunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
        [ObjectiveModel initTitle:@"轮播图" vcName:@"CycleVC"],
        [ObjectiveModel initTitle:@"App埋点测试" vcName:@"BuriesPointTestVC"],
        [ObjectiveModel initTitle:@"照片信息" vcName:@"ImageMessageVC"],
        [ObjectiveModel initTitle:@"一些约束问题" vcName:@"FigureOutLayoutVC"],
        [ObjectiveModel initTitle:@"GCD" vcName:@"GCDVC"],
        [ObjectiveModel initTitle:@"UITextFiled输入限制" vcName:@"TextFiledInputLimitVC"],
        [ObjectiveModel initTitle:@"UITextView输入限制" vcName:@"TextViewInputVC"],
        [ObjectiveModel initTitle:@"网页" vcName:@"LZYPWebViewVC"],
        [ObjectiveModel initTitle:@"小球颤动" vcName:@"BallFibrillationVC"],
        [ObjectiveModel initTitle:@"手机通讯录" vcName:@"PhoneAddressBookVC"],
        [ObjectiveModel initTitle:@"Lottie动画(一)" vcName:@"LotAnimationVC"],
        [ObjectiveModel initTitle:@"获取所有相册照片" vcName:@"AllImageVC"],
        [ObjectiveModel initTitle:@"折叠cell" vcName:@"FoldingCellVC"],
        [ObjectiveModel initTitle:@"自定义键盘" vcName:@"KeyBoardVC"],
        [ObjectiveModel initTitle:@"CollectionView长按拖拽" vcName:@"CollectionViewDragVC"],
        [ObjectiveModel initTitle:@"浏览文件" vcName:@"DocumentVC"],
        [ObjectiveModel initTitle:@"图片的旋转" vcName:@"ImageOrientationVC"],
    ];
//    [[XYGCDTimer shareTimer] timerCutDownFinishedWithTimeInterVal:2 circleBlock:^{
//        [self save];
//    }];
}

- (void)save {
    UIImage *image = [UtilClass screenImageWithSize:CGSizeMake(kScreenWidth, kScreenHeight)];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        XYLog(@"%d", success);
        dispatch_async(dispatch_get_main_queue(), ^{
            [LZYPAlertController initActionAlertWithTitle:@"提示" message:@"成功" presentVC:self];
        });
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ObjectiveModel *model = self.Messages[indexPath.row];
    
    if (model.vcName) {
        if ([model.vcName isEqualToString:@"LZYPWebViewVC"]) {
            LZYPWebViewVC *webVC = [[LZYPWebViewVC alloc] initWithURL:@"https://baijiahao.baidu.com/s?id=1709685926162450607&wfr=spider&for=pc"];
            [self.navigationController pushViewController:webVC animated:YES];
            return;
        }
        UIViewController *vc = [NSClassFromString(model.vcName) new];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        model.vc.title = model.title;
        [self.navigationController pushViewController:model.vc animated:YES];
    }
}


@end
