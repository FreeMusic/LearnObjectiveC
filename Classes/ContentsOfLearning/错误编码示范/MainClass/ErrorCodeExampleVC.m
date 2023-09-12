//
//  ErrorCodeExampleVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "ErrorCodeExampleVC.h"

@interface ErrorCodeExampleVC ()

@end

@implementation ErrorCodeExampleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *string = @{@"key": @"value"};
    XYLog(@"%d", [string isEmptyString])
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"BAD_ACCESS" vcName:@"BAD_ACCESS_VC"],
                      ];
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    //sourcetype有三种分别是camera，photoLibrary和photoAlbum
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //设置媒体类型为public.movie
    ipc.mediaTypes = [NSArray arrayWithObject:@"public.image"];
    ipc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:ipc animated:YES completion:^{
        
    }];
}

@end
