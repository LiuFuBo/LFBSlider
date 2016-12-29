//
//  LFBTitleButton.m
//  新闻列表
//
//  Created by 刘富波 on 16/12/28.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import "LFBTitleButton.h"

@implementation LFBTitleButton

//滑动进度
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_progress > 0 && _progress <= 1) {
        [self setTitleColor:[UIColor colorWithRed:0 + 1*_progress green:0 blue:0 alpha:1] forState:UIControlStateNormal];
        self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1 + 0.1 * _progress, 1 + 0.1 * _progress);
    }
}

@end
