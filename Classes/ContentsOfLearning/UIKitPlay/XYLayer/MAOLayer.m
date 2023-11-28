//
//  MAOLayer.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/11/7.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "MAOLayer.h"

@implementation MAOLayer

- (void)drawInContext:(CGContextRef)ctx {
    //设置为蓝色6
    CGContextSetRGBFillColor(ctx,0,0,1,1);
    //设置起点
    CGContextMoveToPoint(ctx,100,300);
    //从(50, 0)连线到(0, 100)
    CGContextAddLineToPoint(ctx,50,400);
    //从(0, 100)连线到(100, 100)
    CGContextAddLineToPoint(ctx,150,400);
    //合并路径，连接起点和终点
    CGContextClosePath(ctx);
    //绘制路径
    CGContextFillPath(ctx);
}

@end

