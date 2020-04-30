//
//  TextFiledInputLimitVC.m
//  LearnObjectiveC
//
//  Created by 碳银TW on 2020/4/28.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextFiledInputLimitVC.h"
#import "TextFiledInputLimitCell.h"
#import "TextFiledInputModel.h"

@interface TextFiledInputLimitVC ()

@property (nonatomic, strong) NSArray *contentModelArray;//模型数组

@end

@implementation TextFiledInputLimitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentModelArray = [TextFiledInputModel createTextFiledContentArray];
    [self.tableView registerClass:[TextFiledInputLimitCell class] forCellReuseIdentifier:@"TextFiledInputLimitCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextFiledInputLimitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextFiledInputLimitCell"];
    cell.inputModel = self.contentModelArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

@end
