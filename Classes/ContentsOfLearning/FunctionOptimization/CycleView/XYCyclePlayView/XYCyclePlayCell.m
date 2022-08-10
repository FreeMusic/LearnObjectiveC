//
//  XYCyclePlayCell.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2022/8/10.
//  Copyright © 2022 橘子. All rights reserved.
//

#import "XYCyclePlayCell.h"

@interface XYCyclePlayCell ()

@property (nonatomic, strong) UIImageView *loadImageView;///

@end

@implementation XYCyclePlayCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _loadImageView = [[UIImageView alloc] init];
        [self addSubview:_loadImageView];
        [_loadImageView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(0);
        }];
        _loadImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}


- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.loadImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

@end
