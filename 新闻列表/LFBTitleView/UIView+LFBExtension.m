//
//  UIView+LFBExtension.m
//  新闻列表
//
//  Created by 刘富波 on 16/12/27.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import "UIView+LFBExtension.h"

@implementation UIView (LFBExtension)

-(void)setLFB_x:(CGFloat)LFB_x{
    CGRect frame = self.frame;
    frame.origin.x = LFB_x;
    self.frame = frame;
}

-(void)setLFB_y:(CGFloat)LFB_y{

    CGRect frame = self.frame;
    frame.origin.y = LFB_y;
    self.frame = frame;
}

-(void)setLFB_width:(CGFloat)LFB_width{

    CGRect frame = self.frame;
    frame.size.width = LFB_width;
    self.frame = frame;
}

-(void)setLFB_height:(CGFloat)LFB_height{

    CGRect frame = self.frame;
    frame.size.height = LFB_height;
    self.frame = frame;
}


-(void)setLFB_centerX:(CGFloat)LFB_centerX{

    CGPoint center = self.center;
    center.x = LFB_centerX;
    self.center = center;
}

-(void)setLFB_centerY:(CGFloat)LFB_centerY{

    CGPoint center = self.center;
    center.y = LFB_centerY;
    self.center = center;
}


-(void)setLFB_size:(CGSize)LFB_size{

    CGRect frame = self.frame;
    frame.size = LFB_size;
    self.frame = frame;
}

-(void)setLFB_right:(CGFloat)LFB_right{

    self.LFB_x = LFB_right - self.LFB_width;
}

-(void)setLFB_bottom:(CGFloat)LFB_bottom{

    self.LFB_y = LFB_bottom - self.LFB_height;
}


-(CGFloat)LFB_x{

    return self.frame.origin.x;
}

-(CGFloat)LFB_y{

    return self.frame.origin.y;
}

-(CGFloat)LFB_width{

    return self.frame.size.width;
}

-(CGFloat)LFB_height{

    return self.frame.size.height;
}

-(CGFloat)LFB_centerX{

    return self.center.x;
}

-(CGFloat)LFB_centerY{

    return self.center.y;
}

-(CGSize)LFB_size{

    return self.frame.size;
}

-(CGFloat)LFB_right{
 //return self.LFB_x + self.LFB_width;
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)LFB_bottom{
//return self.LFB_y + self.LFB_height;
    return CGRectGetMaxY(self.frame);
}

+(instancetype)lfb_loadNib{

    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
















@end
