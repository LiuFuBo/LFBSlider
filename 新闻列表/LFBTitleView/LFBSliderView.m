//
//  LFBSliderView.m
//  新闻列表
//
//  Created by 刘富波 on 16/12/28.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import "LFBSliderView.h"

@implementation LFBSliderView

//滑动进度
-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (_progress > 0 && _progress <= 1) {
        CGRect frame = self.frame;
        frame.size.width = 15 + _itemWidth * (_progress > 0.5 ? 1 - _progress : _progress);
        frame.origin.x = frame.origin.x + _itemWidth * _progress;
        self.frame = frame;
    }
}

@end
