//
//  MyTableViewVC.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "BaseViewController.h"

@interface MyTableViewVC : BaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) UIImageView *noDataImgView;//无数据背景图

@end
