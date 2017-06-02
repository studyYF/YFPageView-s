//
//  YFSegmentView.m
//  YFPageView
//
//  Created by YangFan on 2017/6/1.
//  Copyright © 2017年 13818556154@163.com. All rights reserved.
//

#import "YFSegmentView.h"
#import "UIView+Size.h"

static CGFloat const margin = 30;




@interface YFButton: UIButton
    
@end

@implementation YFButton

//重写该方法,则当按钮已经被选中后,再点击该按钮不会有高亮的状态
- (void)setHighlighted:(BOOL)highlighted
{
    
}
@end


@interface YFSegmentView ()
/**
 *  放按钮的scrollView,当按钮过多后,可以调整scrollView的contentSize
 */
@property (nonatomic, strong) UIScrollView * scrollView;
/**
 *  上次选中的按钮
 */
@property (nonatomic, strong) UIButton * lastSeletcedButton;
/**
 *  滑动条View
 */
@property (nonatomic, strong) UIView * lineView;

/**
 segmentView属性配置
 */
@property (nonatomic, strong) YFSegmentViewConfig * config;

/**
 按钮数组
 */
@property (nonatomic, strong) NSMutableArray * btnArray;



@end

@implementation YFSegmentView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    if (self = [super initWithFrame:frame]) {
        self.titleArray = titleArray;
    }
    return self;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    [self configButton];
    [self configLineView];
    // 手动刷新布局
    [self setNeedsLayout];
    [self layoutIfNeeded];

}

    //创建下划线
- (void)configLineView
{
    self.backgroundColor = self.config.titleViewBackgroundColor;
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.yf_height - 2, 0, 2)];
    self.lineView.backgroundColor = self.config.lineColor;
    [self.scrollView addSubview:self.lineView];
    
        
}

    //创建标题按钮
- (void)configButton
{
    //    CGFloat btnW = yfWidth / self.titleArray.count;
    
    for (int i = 0; i < self.titleArray.count; i ++) {
        YFButton * button = [YFButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        button.tag = 300 + i;
        [button setTitleColor:self.config.titleButtonColorNormal forState:UIControlStateNormal];
        [button setTitleColor:self.config.titleButtonColorSeletced forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonSeletced:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = self.config.buttonfont;
        [button addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        [self.btnArray addObject:button];
        [self.scrollView addSubview:button];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@",change);
}
    
- (void)buttonSeletced:(UIButton *)button
{
    self.lastSeletcedButton.selected = NO;
    button.selected = !button.selected;
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.yf_width = button.titleLabel.yf_width + 10;
        self.lineView.yf_centerX = button.yf_centerX;
    }];
    if ([self.delegate respondsToSelector:@selector(seletcedTitle:direction:)]) {
        [self.delegate seletcedTitle:button.tag - 300 direction:self.lastSeletcedButton.tag - button.tag > 0 ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward];
    }
    self.lastSeletcedButton = button;
    [self scrollScrollViewWithSeletcedButton:button];
}
    
    //移动选中按钮
- (void)moveSeletcedButton:(NSInteger)index
{
    UIButton * button = self.scrollView.subviews[index];
    [self buttonSeletced:button];
    [self scrollScrollViewWithSeletcedButton:button];
}
#pragma mark -- 调整scrollView的contentOffset
- (void)scrollScrollViewWithSeletcedButton:(UIButton *)button
{
    //判断按钮是否在屏幕之外,如果不在则需要调整scrollView的contentOffset
    //右边界
    CGFloat reduceValue = CGRectGetMaxX(button.frame) + margin - yfWidth - self.scrollView.contentOffset.x;
    if (reduceValue > 0)  {
        [self.scrollView setContentOffset:CGPointMake(reduceValue + self.scrollView.contentOffset.x, 0) animated:YES];
    } else {
        //左边界
        CGFloat leftValue = CGRectGetMinX(button.frame) - margin - self.scrollView.contentOffset.x;
        if (leftValue < 0) {
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + leftValue, 0) animated:YES];
        }
    }
}

- (void)updateConfig:(void(^)(YFSegmentViewConfig * config))configBlock
{
    if (configBlock) {
        configBlock(self.config);
    }
    
    for (UIButton * button in self.btnArray) {
        [button setTitleColor:self.config.titleButtonColorNormal forState:UIControlStateNormal];
        [button setTitleColor:self.config.titleButtonColorSeletced forState:UIControlStateSelected];
        button.titleLabel.font = self.config.buttonfont;
    }
    self.lineView.backgroundColor = self.config.lineColor;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //调整按钮位置
    CGFloat lastButtonMaxX = 0;
    for (int i = 0; i < self.btnArray.count; i ++) {
        YFButton * button = self.btnArray[i];
        CGFloat btnW = [self.titleArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.yf_height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.config.buttonfont} context:nil].size.width + 10;
        button.frame = CGRectMake(margin + lastButtonMaxX, 0 , btnW, self.yf_height);
        lastButtonMaxX = CGRectGetMaxX(button.frame);
    }
    //调整下划线位置
    self.lineView.frame = CGRectMake(0, self.yf_height - 2, 0, 2);
    YFButton * firstButton = self.scrollView.subviews[0];
    firstButton.selected = YES;
    self.lastSeletcedButton = firstButton;
    //让第一个button计算里面label的尺寸,不然获取到的label的宽度是0
    [firstButton.titleLabel sizeToFit];
    self.lineView.yf_width = firstButton.titleLabel.yf_width + 10;
    self.lineView.yf_centerX = firstButton.yf_centerX;
    self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.scrollView.subviews[self.titleArray.count - 1].frame) + margin, 0);
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.alwaysBounceVertical = false;
        scrollView.backgroundColor = self.backgroundColor;
        _scrollView = scrollView;
        [self addSubview:scrollView];
    }
    return _scrollView;
}


- (YFSegmentViewConfig *)config
{
    if (!_config) {
        YFSegmentViewConfig * config = [YFSegmentViewConfig configSegment];
        _config = config;
    }
    return _config;
}
    
- (NSMutableArray *)btnArray
{
    if (!_btnArray ) {
        NSMutableArray * a = [NSMutableArray array];
        _btnArray = a;
    }
    return _btnArray;
}
    
    
    
    

@end
