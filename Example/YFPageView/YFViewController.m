//
//  YFViewController.m
//  YFPageView
//
//  Created by 13818556154@163.com on 05/27/2017.
//  Copyright (c) 2017 13818556154@163.com. All rights reserved.
//

#import "YFViewController.h"
#import "YFPageViewController.h"
#define RandomColor [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1]
@interface YFViewController ()

@property (nonatomic, strong) YFPageViewController * pageViewController;

@end

@implementation YFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"YFPageViewTest";
    
    //创建控制器，并添加为当前控制器的子控制器
    self.pageViewController = [[YFPageViewController alloc] init];
    [self addChildViewController:self.pageViewController];
    
    //设置view的frame
    self.pageViewController.view.frame = self.view.bounds;
    //设置segmentView的frame
    self.pageViewController.segmentView.frame = CGRectMake(0, 0, yfWidth, 44);
    [self.view addSubview:self.pageViewController.view];
    
    //设置segment的参数
    ///链式编程调用，类似masonry
    [self.pageViewController.segmentView updateConfig:^(YFSegmentViewConfig *config) {
        //链式设置属性
        config.normalColor([UIColor lightGrayColor]).seletcedColor([UIColor redColor]).line([UIColor redColor]).font(14).viewBackColor([UIColor whiteColor]);
        //普通设置属性
//        config.titleButtonColorNormal = [UIColor lightGrayColor];
//        config.titleButtonColorSeletced = [UIColor orangeColor];
//        config.lineColor = [UIColor orangeColor];
//        config.buttonfont = [UIFont systemFontOfSize:14];
    }];

    //设置每个item的控制器
    NSMutableArray * vcArray = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        UIViewController * vc = [UIViewController new];
        vc.view.backgroundColor = RandomColor;
        [vcArray addObject:vc];
    }
    //设置item的标题
    NSArray * titleArray = @[@"你啊后",@"再见",@"考试",@"回家",@"总决赛"];
    //设置控件
    [self.pageViewController setContentWithTitles:titleArray vcs:vcArray];
}

- (YFPageViewController *)pageViewController
{
    if (!_pageViewController) {
        YFPageViewController * vc = [[YFPageViewController alloc] init];
        vc.isNeedScroll = NO;
        [self addChildViewController:vc];
        _pageViewController = vc;
    }
    return _pageViewController;
}

@end
