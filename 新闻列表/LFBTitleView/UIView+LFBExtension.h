//
//  UIView+LFBExtension.h
//  新闻列表
//
//  Created by 刘富波 on 16/12/27.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LFBExtension)

@property (nonatomic,assign) CGFloat LFB_x;
@property (nonatomic,assign) CGFloat LFB_y;
@property (nonatomic,assign) CGFloat LFB_width;
@property (nonatomic,assign) CGFloat LFB_height;
@property (nonatomic,assign) CGFloat LFB_centerX;
@property (nonatomic,assign) CGFloat LFB_centerY;

@property (nonatomic,assign) CGSize  LFB_size;

@property (nonatomic,assign) CGFloat LFB_right;
@property (nonatomic,assign) CGFloat LFB_bottom;

+(instancetype)lfb_loadNib;

@end
