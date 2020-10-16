//
//  FunctionVC.m
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/13.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "FunctionVC.h"
#import "LZYPWebViewVC.h"

@interface FunctionVC ()

@end

@implementation FunctionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Messages = @[
                      [ObjectiveModel initTitle:@"App埋点测试" vcName:@"BuriesPointTestVC"],
                      [ObjectiveModel initTitle:@"照片信息" vcName:@"ImageMessageVC"],
                      [ObjectiveModel initTitle:@"一些约束问题" vcName:@"FigureOutLayoutVC"],
                      [ObjectiveModel initTitle:@"GCD" vcName:@"GCDVC"],
                      [ObjectiveModel initTitle:@"UITextFiled输入限制" vcName:@"TextFiledInputLimitVC"],
                      [ObjectiveModel initTitle:@"网页" vcName:@"LZYPWebViewVC"],
                      ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ObjectiveModel *model = self.Messages[indexPath.row];
    
    if (model.vcName) {
        if ([model.vcName isEqualToString:@"LZYPWebViewVC"]) {
            LZYPWebViewVC *webVC = [[LZYPWebViewVC alloc] initWithURL:@"https://www.baidu.com"];
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
