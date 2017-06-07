//
//  UILabel+Swizzling.m
//  RunTimeProj
//
//  Created by 杨海涛 on 6/7/17.
//  Copyright © 2017 杨海涛. All rights reserved.
//

#import "UILabel+Swizzling.h"
#import "NSObject+Swizzling.h"

@implementation UILabel (Swizzling)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(init) bySwizzledSelector:@selector(sure_Init)];
        [self methodSwizzlingWithOriginalSelector:@selector(initWithFrame:) bySwizzledSelector:@selector(sure_InitWithFrame:)];
        [self methodSwizzlingWithOriginalSelector:@selector(awakeFromNib) bySwizzledSelector:@selector(sure_AwakeFromNib)];
    });
}
- (instancetype)sure_Init{
    id __self = [self sure_Init];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
    return __self;
}
- (instancetype)sure_InitWithFrame:(CGRect)rect{
    id __self = [self sure_InitWithFrame:rect];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
    return __self;
}

- (void)sure_AwakeFromNib{
    [self sure_AwakeFromNib];
    UIFont * font = [UIFont fontWithName:@"Zapfino" size:self.font.pointSize];
    if (font) {
        self.font=font;
    }
}

@end
