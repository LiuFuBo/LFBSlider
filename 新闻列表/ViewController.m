//
//  ViewController.m
//  新闻列表
//
//  Created by 刘富波 on 16/12/27.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import "ViewController.h"
#import "LFBSliderViewController.h"
#import "FirstViewController.h"


@interface ViewController ()<LFBSliderViewControllerDelegate>
/** 滑动选项*/
@property (nonatomic, strong) LFBSliderViewController *sliderVc;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initilizeAppeareces];
}
-(void)initilizeAppeareces{

    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.sliderVc];
    [self.view addSubview:self.sliderVc.view];
}

#pragma mark - LFBSliderViewControllerDelegate methods

-(NSArray<NSString *> *)lfb_titlesArrayInSliderViewController{
 return @[@"打开",@"温柔",@"权威",@"藕片",@"风格",@"链接",@"电视",@"快乐",@"漂亮",@"配合",@"瓯海",@"提升"];
}

-(UIViewController *)lfb_sliderViewController:(LFBSliderViewController *)sliderVC subViewControllerAtIndex:(NSInteger)index{

    return [FirstViewController new];
}

/**  设置居中对齐还是滚动对齐 */
-(BOOL)lfb_sliderViewScrollAlignmentStyle{
    
    return YES;
}
/** 设置指示器颜色 */
-(UIColor *)lfb_sliderViewColor{
    return [UIColor redColor];
}

-(LFBSliderViewController *)sliderVc{

    return _sliderVc?:({
        _sliderVc = [LFBSliderViewController new];
        _sliderVc.delegate = self;
        _sliderVc;
    });
}




@end
