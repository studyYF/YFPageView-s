//
//  YFPageViewController.h
//  YFPageView
//
//  Created by YF on 16/10/21.
//  Copyright © 2016年 YF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFSegmentView.h"

@interface YFPageViewController : UIViewController
/**
 *  分类标题视图
 */
@property (nonatomic, strong) YFSegmentView * segmentView;

/**
 控制器是否滚动切换，默认是YES
 */
@property (nonatomic, assign) BOOL isNeedScroll;

/**
 *  移动当前显示的控制器
 *
 *  @param index     下标
 *  @param direction 方向,左滑,右滑
 */
- (void)seletcedTitle:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction;

/**
 设置控制器和标题

 @param titles 标题名
 @param vcs 控制器
 */
- (void)setContentWithTitles:(NSArray *)titles vcs:(NSMutableArray *)vcs;

@end
