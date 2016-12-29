//
//  LFBScrollView.h
//  新闻列表
//
//  Created by 刘富波 on 16/12/28.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFBScrollView : UIScrollView

/** 标题数组 */
@property (nonatomic, strong) NSArray <NSString *> *titleArray;
/** item点击回调*/
@property (nonatomic, copy) void(^titleItemClickedCallBackBlock)(NSInteger index);
/** 偏移量 */
@property (nonatomic, assign) CGFloat contentOffSetX;
/** 设置居中对齐方式 */
@property (nonatomic, assign) BOOL aligmentStyle;
/** 设置指示器颜色 */
@property (nonatomic, strong) UIColor *indicatorColor;


/** 类方法 */
+(instancetype)lfbScrollViewWithFrame:(CGRect)frame;


@end
