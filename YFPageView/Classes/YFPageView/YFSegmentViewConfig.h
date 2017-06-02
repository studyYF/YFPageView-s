//
//  YFSegmentViewConfig.h
//  YFPageView
//
//  Created by YangFan on 2017/6/1.
//  Copyright © 2017年 13818556154@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFSegmentViewConfig : NSObject

/**标题按钮普通颜色*/
@property (nonatomic, strong) UIColor * titleButtonColorNormal;
/**标题按钮选中颜色*/
@property (nonatomic, strong) UIColor * titleButtonColorSeletced;
/**按钮下的滑动条颜色*/
@property (nonatomic, strong) UIColor * lineColor;
/**标题view背景色 */
@property (nonatomic, strong) UIColor * titleViewBackgroundColor;
/**标题按钮字体大小 */
@property (nonatomic, assign) UIFont* buttonfont;

//链式编程
@property (nonatomic, copy, readonly) YFSegmentViewConfig * (^normalColor)(UIColor * color);

@property (nonatomic, copy, readonly) YFSegmentViewConfig * (^seletcedColor)(UIColor * color);

@property (nonatomic, copy, readonly) YFSegmentViewConfig * (^line)(UIColor * color);

@property (nonatomic, copy, readonly) YFSegmentViewConfig * (^viewBackColor)(UIColor * color);

@property (nonatomic, copy, readonly) YFSegmentViewConfig * (^font)(CGFloat font);








+ (instancetype)configSegment;

@end
