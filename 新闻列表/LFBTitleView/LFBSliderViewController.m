//
//  LFBSliderViewController.m
//  新闻列表
//
//  Created by 刘富波 on 16/12/28.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import "LFBSliderViewController.h"
#import "LFBScrollView.h"

@interface LFBSliderViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) LFBScrollView *optionalView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray<NSString *> *titleArrays;

@end

static const CGFloat optionalViewHeight = 40.0;

@implementation LFBSliderViewController{

    /** 缓存VC */
    NSMutableArray<NSNumber *> *_cacheVC;
}

- (void)dealloc{
    [self removeObserver:_optionalView forKeyPath:@"_optionalView.sliderView.frame"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   /** 添加子视图 */
    [self initSubViews];
   /** 处理事件回调*/
    [self dealButtonCallBackBlock];
    /** 设置标题滚动方式 */
    [self p_SetScrollViewAlignmentStyle];
    /** 设置活动指示器颜色 */
    [self p_SetIndicatorColor];
   
}

-(void)initSubViews{
    _cacheVC = [NSMutableArray arrayWithCapacity:0];
    self.view.frame = CGRectMake(self.view.frame.origin.x, [self getOptionalStartY], self.view.frame.size.width, optionalViewHeight + [self getScrollViewHeight]);
    [self.view addSubview:self.optionalView];
    [self.view addSubview:self.mainScrollView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.optionalView.aligmentStyle = YES;
    [self initializeSubViewControllerAtIndex:0];
    self.mainScrollView.contentSize = CGSizeMake(_titleArrays.count*self.view.frame.size.width, self.mainScrollView.frame.size.height);
}

/** 处理回调事件 */
-(void)dealButtonCallBackBlock{

    __weak LFBSliderViewController *weakSelf = self;
    _optionalView.titleItemClickedCallBackBlock = ^(NSInteger index){
        weakSelf.mainScrollView.contentOffset = CGPointMake((index - 100) *self.view.frame.size.width, 0);
    };
}

/** 设置滚动对齐方式 */
-(void)p_SetScrollViewAlignmentStyle{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lfb_sliderViewScrollAlignmentStyle)]) {
        self.optionalView.aligmentStyle = [self.delegate lfb_sliderViewScrollAlignmentStyle];
    }
}

/** 设置活动指示器的颜色 */
-(void)p_SetIndicatorColor{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lfb_sliderViewColor)]) {
        self.optionalView.indicatorColor = [self.delegate lfb_sliderViewColor];
    }
}

#pragma mark - private 

-(CGFloat)getOptionalStartY{

    if (self.delegate && [self.delegate respondsToSelector:@selector(lfb_optionalViewStartYInSliderViewController)]) {
        return [self.delegate lfb_optionalViewStartYInSliderViewController];
    }else{
    
        return 20;
    }
}

-(CGFloat)getScrollViewHeight{

    if (self.delegate &&[self.delegate respondsToSelector:@selector(lfb_viewOfChildViewControllerHeightInSliderViewController)]) {
        return [self.delegate lfb_viewOfChildViewControllerHeightInSliderViewController];
    }else{
    return [UIScreen mainScreen].bounds.size.height - optionalViewHeight - 20;
    }
}

-(void)initializeSubViewControllerAtIndex:(NSInteger)index{
 //添加子控制器
    if (self.delegate && [self.delegate respondsToSelector:@selector(lfb_sliderViewController:subViewControllerAtIndex:)]) {
        UIViewController *vc = [self.delegate lfb_sliderViewController:self subViewControllerAtIndex:index];
        if (![_cacheVC containsObject:[NSNumber numberWithInteger:index]]) {
             [_cacheVC addObject:[NSNumber numberWithInteger:index]];
            vc.view.frame = CGRectMake(index * vc.view.frame.size.width, 0, vc.view.frame.size.width, self.mainScrollView.frame.size.height);
            [self addChildViewController:vc];
            [self.mainScrollView addSubview:vc.view];
        }
    }
}

#pragma mark - scrollViewDelegate method
/** 偏移量控制显示 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x /(scrollView.frame.size.width + 1);
    [self initializeSubViewControllerAtIndex:index + 1];
    self.optionalView.contentOffSetX = scrollView.contentOffset.x;
}


#pragma mark - getter
-(LFBScrollView *)optionalView{

    return _optionalView?:({
        _optionalView = [[LFBScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,optionalViewHeight)];
        _optionalView.titleArray = self.titleArrays;
        _optionalView;
    });
}

-(UIScrollView *)mainScrollView{
    return _mainScrollView?:({
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.optionalView.frame), self.view.frame.size.width, [self getScrollViewHeight])];
        _mainScrollView.delegate = self;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.bounces = NO;
        _mainScrollView;
    });
}

-(NSArray<NSString *> *)titleArrays{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lfb_titlesArrayInSliderViewController)]) {
        _titleArrays = [self.delegate lfb_titlesArrayInSliderViewController];
    }
    return _titleArrays;
}




@end
