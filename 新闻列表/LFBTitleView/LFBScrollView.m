//
//  LFBScrollView.m
//  新闻列表
//
//  Created by 刘富波 on 16/12/28.
//  Copyright © 2016年 mac1. All rights reserved.
//

#import "LFBScrollView.h"
#import "LFBTitleButton.h"
#import "LFBSliderView.h"
#import "UIView+LFBExtension.h"

#define labelFontOfSize  [UIFont systemFontOfSize:15]
#define LFB_screenWidth [UIScreen mainScreen].bounds.size.width
#define selectedTitleAndIndicatorViewColor [UIColor redColor]

@interface LFBScrollView ()
/** 滑动条 */
@property (nonatomic, strong) LFBSliderView *sliderView;

@end

@implementation LFBScrollView

/** button之间的间距 */
static CGFloat const labelMargin = 15;
/** 选中标题对应slider的高度 */
static CGFloat const sliderHeight = 2;
/** 滑动条宽度 */
static const CGFloat sliderViewWidth = 15;
/** 标题默认宽度 */
static const CGFloat itemWidth = 60;

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.sliderView];
        /** 监听frame改变 */
        [self addObserver:self forKeyPath:@"_sliderView.frame" options:NSKeyValueObservingOptionNew context:nil];
        self.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.9];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

+(instancetype)lfbScrollViewWithFrame:(CGRect)frame{

    return [[self alloc] initWithFrame:frame];
}

/** 接收通知 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (self.aligmentStyle) {
        //计算偏移量
        CGFloat offSetX  = self.sliderView.center.x - LFB_screenWidth/2;
        if (offSetX< 0) offSetX = 0;
        
        // 获取最大滚动范围
        CGFloat maxOffsetX = self.contentSize.width - LFB_screenWidth;
        
        if (offSetX > maxOffsetX) offSetX = maxOffsetX;
        
        // 滚动标题滚动条
        [self setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    }else{
        CGFloat itemVisionblePositionMax = _sliderView.frame.origin.x - (itemWidth - sliderViewWidth)/2 + 2*itemWidth;
        CGFloat itemVisionblePositionMin = _sliderView.frame.origin.x - (itemWidth - sliderViewWidth)/2 - itemWidth;
        
        // 右滑
        if (itemVisionblePositionMax >= self.frame.size.width + self.contentOffset.x &&
            itemVisionblePositionMax <= self.contentSize.width) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentOffset = CGPointMake(itemVisionblePositionMax - self.frame.size.width, 0);
            }];
        }
        // 左滑
        if (itemVisionblePositionMin < self.contentOffset.x &&
            itemVisionblePositionMin >= 0) {
            [UIView animateWithDuration:0.2 animations:^{
                self.contentOffset = CGPointMake(itemVisionblePositionMin, 0);
            }];
        }
    }
    
}

/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

#pragma mark - getter
-(void)setTitleArray:(NSArray<NSString *> *)titleArray{
    _titleArray = titleArray;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonH = self.frame.size.height - sliderHeight *0.5;
    
    for (NSUInteger i = 0; i< titleArray.count; i++) {
        
        //创建button
        LFBTitleButton *item = [[LFBTitleButton alloc]init];
        item.userInteractionEnabled = YES;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [item setTitle:titleArray[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        item.tag = i+ 100;
        //获取标题
        NSString *titleValue = titleArray[i];
        //计算标题内容的Size
        CGSize titleSize = [self sizeWithText:titleValue font:labelFontOfSize maxSize:CGSizeMake(MAXFLOAT, buttonH)];
        //计算button的宽度
        CGFloat buttonW = titleSize.width + 2 * labelMargin;
        //设置button的frame
        item.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //计算每个button的X值
        buttonX = buttonX + buttonW;
        if (i == 0) {
            self.sliderView.frame = CGRectMake((buttonW-sliderViewWidth)/2, self.frame.size.height-2, sliderViewWidth, 2);
            self.sliderView.itemWidth = buttonW;
        }
        [self addSubview:item];
    }
    
    //第一个item更改样式
    LFBTitleButton *firstItem = [self viewWithTag:100];
    [firstItem setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    firstItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    //计算scrollViewWidth的宽度
    CGFloat scrollViewWidth = CGRectGetMaxX(self.subviews.lastObject.frame);
    self.contentSize = CGSizeMake(scrollViewWidth, self.frame.size.height);
}

-(void)setContentOffSetX:(CGFloat)contentOffSetX{
    _contentOffSetX = contentOffSetX;
    NSInteger index = (NSInteger)contentOffSetX / (NSInteger)[UIScreen mainScreen].bounds.size.width;
    // progress 0(屏幕边缘开始) -  1 （满屏结束）
    CGFloat progress =( _contentOffSetX - index * [UIScreen mainScreen].bounds.size.width )/ [[UIScreen mainScreen]bounds].size.width;
    //左右选项卡
    LFBTitleButton *leftItem = [self viewWithTag:index + 100];
    LFBTitleButton *rightItem = [self viewWithTag:index + 101];
    //item 根据progress改变状态
    leftItem.progress = 1- progress;
    rightItem.progress = progress;
  //选中button之前的偏移量X
    CGFloat beforeWidht = 0;
    CGFloat buttonW = 0;
    if (index == 0) {
        beforeWidht = 0;
        buttonW = CGRectGetWidth(self.subviews[index+1].frame);
    }else{
      beforeWidht = CGRectGetMaxX(self.subviews[index].frame);
      buttonW =   CGRectGetWidth(self.subviews[index+1].frame);
    }
  //设置滑条sliderView 根据progress 改变状态
    CGRect frame = self.sliderView.frame;
    frame.origin.x = beforeWidht + (buttonW-sliderViewWidth-8)/2;
    self.sliderView.frame = frame;
    self.sliderView.progress = progress;
}

#pragma mark - button event

-(void)itemClicked:(LFBTitleButton *)sender{

    NSInteger index = (NSInteger)_contentOffSetX / (NSInteger)[UIScreen mainScreen].bounds.size.width;
    if (sender.tag - 100 == index) return;
    LFBTitleButton *currentItem = [self viewWithTag:index + 100];
    
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [currentItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    CGRect frame = _sliderView.frame;
    CGFloat beforeWidht = 0; CGFloat buttonW  = 0 ;
    //当选择第一个item的时候，系统的子控件的第一个子控件是指示控制器，所以要单独处理
    if (sender.tag == 100) {
        beforeWidht = 0.0f;
        LFBTitleButton *firstButton = [self viewWithTag:100];
        buttonW = CGRectGetWidth(firstButton.frame);
    }else{
        //选中button之前的偏移量X
         beforeWidht = CGRectGetMaxX(self.subviews[sender.tag-100].frame);
        //当前button的宽度
         buttonW = CGRectGetWidth(self.subviews[sender.tag-99].frame);
    }
    
       frame.origin.x = beforeWidht + (buttonW - sliderViewWidth-8)/2;
    [UIView animateWithDuration:0.6f animations:^{
        sender.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        currentItem.transform = CGAffineTransformIdentity;
        self.sliderView.frame = frame;
    }];
    
    !_titleItemClickedCallBackBlock ? : _titleItemClickedCallBackBlock(sender.tag);

}

#pragma mark - setter
-(void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    self.sliderView.backgroundColor = indicatorColor;
}

#pragma mark - getter
-(LFBSliderView *)sliderView{
    
    return _sliderView?:({
        _sliderView = [LFBSliderView new];
        _sliderView.backgroundColor = [UIColor redColor];
        _sliderView.layer.cornerRadius = 2;
        _sliderView.layer.masksToBounds = YES;
        _sliderView;
    });
}

@end
