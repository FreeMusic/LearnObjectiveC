//
//  FigureOutLayoutVC.m
//  LearnObjectiveC
//
//  Created by Apple on 2019/7/11.
//  Copyright © 2019 橘子. All rights reserved.
//

#import "FigureOutLayoutVC.h"
#import "LayOutCell.h"

@interface FigureOutLayoutVC ()

@end

@implementation FigureOutLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[LayOutCell class] forCellReuseIdentifier:@"LayOutCell"];
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth/2, kScreenHeight);
}

#pragma  UITableViewDataSource---numberOfRowsInSection
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma UITableViewDataSource---cellForRowAtIndexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LayOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LayOutCell"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 400*m6Scale;
}

@end
