//
//  YFSegmentView.h
//  YFPageView
//
//  Created by YangFan on 2017/6/1.
//  Copyright © 2017年 13818556154@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFSegmentViewConfig.h"

#define yfWidth [UIScreen mainScreen].bounds.size.width
#define yfHeight [UIScreen mainScreen].bounds.size.height

@protocol YFSegmentViewDelegate <NSObject>
    /**
     *  选中了某个title
     */
- (void)seletcedTitle:(NSInteger)index direction:(UIPageViewControllerNavigationDirection)direction;
    
    @end


@interface YFSegmentView : UIView
    
    
@property (nonatomic, assign) id <YFSegmentViewDelegate> delegate;

/**
 *  标题分类数组
 */
@property (nonatomic, strong) NSArray * titleArray;

/**
 *  初始化创建标题分类视图
 *
 *  @param frame      坐标
 *  @param titleArray 标题数组
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

/**
 *  移动当前的选中title
 *
 *  @param index 选中的index
 */
- (void)moveSeletcedButton:(NSInteger)index;

/**
 配置segmentView

 @param configBlock config
 */
- (void)updateConfig:(void(^)(YFSegmentViewConfig * config))configBlock;

@end
