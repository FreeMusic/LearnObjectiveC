//
//  TextViewInputVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2020/11/19.
//  Copyright © 2020 橘子. All rights reserved.
//

#import "TextViewInputVC.h"
#import "TextViewInputCell.h"
#import "TextViewInputModel.h"

@interface TextViewInputVC ()

@property (nonatomic, strong) NSArray *contentArray;///

@end

@implementation TextViewInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentArray = [TextViewInputModel inputTextViewContentModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewInputCell *inputCell = [TextViewInputCell cellReuseWithTableView:tableView];
    inputCell.inputModel = [self.contentArray objectAtIndex:indexPath.row];
    
    return inputCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
