//
//  YFSegmentViewConfig.m
//  YFPageView
//
//  Created by YangFan on 2017/6/1.
//  Copyright © 2017年 13818556154@163.com. All rights reserved.
//

#import "YFSegmentViewConfig.h"

@interface YFSegmentViewConfig()


@end


@implementation YFSegmentViewConfig

+ (instancetype)configSegment
{
    YFSegmentViewConfig * config = [[YFSegmentViewConfig alloc] init];
    config.titleButtonColorNormal = [UIColor blackColor];
    config.titleButtonColorSeletced = [UIColor orangeColor];
    config.lineColor = [UIColor redColor];
    config.titleViewBackgroundColor = [UIColor whiteColor];
    config.buttonfont = [UIFont systemFontOfSize:16];
    return  config;
}

- (YFSegmentViewConfig *(^)(UIColor *))normalColor
{
    return ^(UIColor * color) {
        self.titleButtonColorNormal = color;
        return self;
    };
}

- (YFSegmentViewConfig *(^)(UIColor *))seletcedColor
{
    return ^(UIColor * color) {
        self.titleButtonColorSeletced = color;
        return self;
    };
}

- (YFSegmentViewConfig *(^)(UIColor *))viewBackColor
{
    return ^(UIColor * color) {
        self.titleViewBackgroundColor = color;
        return self;
    };
}

- (YFSegmentViewConfig *(^)(CGFloat))font
{
    return ^(CGFloat font) {
        self.buttonfont = [UIFont systemFontOfSize:font];
        return self;
    };
}

- (YFSegmentViewConfig *(^)(UIColor *))line
{
    return ^(UIColor * color) {
        self.lineColor = color;
        return self;
    };
}



@end
