//
//  UINavigationItem+Swizzling.m
//  RunTimeProj
//
//  Created by 杨海涛 on 6/7/17.
//  Copyright © 2017 杨海涛. All rights reserved.
//

#import "UINavigationItem+Swizzling.h"
#import "NSObject+Swizzling.h"

static char *kCustomBackButtonKey;

@implementation UINavigationItem (Swizzling)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(backBarButtonItem)
                               bySwizzledSelector:@selector(sure_backBarButtonItem)];
        
    });
}

- (UIBarButtonItem*)sure_backBarButtonItem {
    UIBarButtonItem *backItem = [self sure_backBarButtonItem];
    if (backItem) {
        return backItem;
    }
    backItem = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!backItem) {
        backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, backItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return backItem;
}
@end
