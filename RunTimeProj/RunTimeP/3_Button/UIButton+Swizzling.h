//
//  UIButton+Swizzling.h
//  RunTimeProj
//
//  Created by 杨海涛 on 6/7/17.
//  Copyright © 2017 杨海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

//默认时间间隔
#define defaultInterval 2

@interface UIButton (Swizzling)

//点击间隔
@property (nonatomic, assign) NSTimeInterval timeInterval;
//用于设置单个按钮不需要被hook
@property (nonatomic, assign) BOOL isIgnore;

@end
