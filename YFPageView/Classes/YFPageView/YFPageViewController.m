//
//  YFPageViewController.m
//  YFPageView
//
//  Created by YF on 16/10/21.
//  Copyright © 2016年 YF. All rights reserved.
//



#import "YFPageViewController.h"
#import "UIView+Size.h"


@interface YFPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,YFSegmentViewDelegate>
/**
 *  pageViewController保存控制器的容器
 */
@property (nonatomic, strong) UIPageViewController * pageViewController;

/**
 *  将要滑动到的控制器
 */
@property (nonatomic, strong) UIViewController * pendingViewController;

/**控制器数组 */
@property (nonatomic, strong) NSMutableArray  * vcArray;


@end

@implementation YFPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (BOOL)isNeedScroll {
    if (!_isNeedScroll) {
        _isNeedScroll = YES;
    }
    return _isNeedScroll;
}

- (void)setContentWithTitles:(NSArray *)titles vcs:(NSMutableArray *)vcs
{
    self.segmentView.titleArray = titles;
    self.vcArray = vcs;
    [self.segmentView moveSeletcedButton:0];
    [self startLayout];
}

//根据设置的titleView的样式创建控件
- (void)startLayout
{
    self.pageViewController.view.frame = CGRectMake(0, self.segmentView.yf_height, yfWidth, self.view.yf_height - self.segmentView.yf_height);
}

#pragma mark -- HeaderTitleViewDelegate
- (void)seletcedTitle:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction
{
    //
    [self.pageViewController setViewControllers:@[self.vcArray[index]] direction:direction animated:_isNeedScroll completion:nil];
}

#pragma mark -- UIPageViewControllerDataSource
//往右滑(返回)
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //如果到第一个,不作处理
    NSInteger index = [self.vcArray indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    return self.vcArray[index - 1];
}
//往左滑(下一个)
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    //如果超出数组则不作处理
    NSInteger index = [self.vcArray indexOfObject:viewController];
    if (index ==  self.vcArray.count - 1 || index == NSNotFound) {
        return nil;
    }
    return self.vcArray[index + 1];
}
#pragma mark -- UIPageViewControllerDelegate
//即将开始动画代理
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    //pendingViewControllers 数组存放的是将要移动到的ViewController
    self.pendingViewController = pendingViewControllers[0];
}

//动画完成代理
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    //previousViewControllers 该数组里面存放的是滑动之前的viewController
    if (completed) {
        [self.segmentView moveSeletcedButton:[self.vcArray indexOfObject:self.pendingViewController]];
    }
}
#pragma mark -- 懒加载
- (UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        UIPageViewController * pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionSpineLocationKey : @0}];
        pageViewController.delegate = self;
        pageViewController.dataSource = self;
        [pageViewController setViewControllers:@[self.vcArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        _pageViewController = pageViewController;
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
    }
    return _pageViewController;
}





- (UIView *)segmentView
{
    if (!_segmentView) {
        YFSegmentView * segmentView = [[YFSegmentView alloc] initWithFrame:CGRectZero];
        segmentView.delegate = self;
//        segmentView.titleButtonColorNormal = self.titleButtonColorNormal;
//        segmentView.titleButtonColorSeletced = self.titleButtonColorSeletced;
//        segmentView.lineColor = self.lineColor;
//        segmentView.buttonfont = self.buttonfont;
        _segmentView = segmentView;
        [self.view addSubview:_segmentView];
    }
    return _segmentView;
}





@end
