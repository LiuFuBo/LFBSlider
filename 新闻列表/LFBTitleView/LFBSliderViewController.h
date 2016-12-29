//
//  LFBSliderViewController.h
//  新闻列表
//
//  Created by 刘富波 on 16/12/28.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFBSliderViewController;
@protocol LFBSliderViewControllerDelegate <NSObject>
/** 标题个数 */
-(NSArray<NSString *> *)lfb_titlesArrayInSliderViewController;
/** index对应的子控制器 */
-(UIViewController *)lfb_sliderViewController:(LFBSliderViewController *)sliderVC subViewControllerAtIndex:(NSInteger)index;
@optional
/** 子视图高度 (不包含lfbscrollview的子视图高度,lfbscrollview高度40) 默认适配全屏*/
-(CGFloat)lfb_viewOfChildViewControllerHeightInSliderViewController;
/** 子视图的起始位置 (y),默认在状态栏之下 */
-(CGFloat)lfb_optionalViewStartYInSliderViewController;
/** 视图标题是居中对齐 */
-(BOOL)lfb_sliderViewScrollAlignmentStyle;
/** 指示器颜色 */
-(UIColor *)lfb_sliderViewColor;



@end


@interface LFBSliderViewController : UIViewController

@property (nonatomic, weak) id <LFBSliderViewControllerDelegate> delegate;

@end
