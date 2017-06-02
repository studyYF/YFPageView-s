# YFPageView

[![CI Status](http://img.shields.io/travis/13818556154@163.com/YFPageView.svg?style=flat)](https://travis-ci.org/13818556154@163.com/YFPageView)
[![Version](https://img.shields.io/cocoapods/v/YFPageView.svg?style=flat)](http://cocoapods.org/pods/YFPageView)
[![License](https://img.shields.io/cocoapods/l/YFPageView.svg?style=flat)](http://cocoapods.org/pods/YFPageView)
[![Platform](https://img.shields.io/cocoapods/p/YFPageView.svg?style=flat)](http://cocoapods.org/pods/YFPageView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

YFPageView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YFPageView"
```

## Usage
1.引用头文件 ```#import "YFPageViewController.h"```
2.
```
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
```

## License

YFPageView is available under the MIT license. See the LICENSE file for more info.
