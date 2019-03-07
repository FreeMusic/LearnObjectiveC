//
//  MyTableReFreshVC.h
//  LearnObjectiveC
//
//  Created by 橘子 on 2019/3/7.
//  Copyright © 2019年 橘子. All rights reserved.
//

#import "MyTableViewVC.h"

@interface MyTableReFreshVC : MyTableViewVC

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源
@property (nonatomic, assign) NSInteger page;

/**
 请求数据
 */
- (void)serviceData;
/**
 请求数据成功后 刷新tableView
 */
- (void)refreshTableViewWithDataSource:(NSArray *)array;

@end
