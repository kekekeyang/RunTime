//
//  UIViewController+Swizzling.m
//  RunTimeProj
//
//  Created by 杨海涛 on 6/7/17.
//  Copyright © 2017 杨海涛. All rights reserved.
//

#import "UIViewController+Swizzling.h"

@implementation UIViewController (Swizzling)

/**
 App跳转到某具有网络请求的界面时，为了用户体验效果常会添加加载栏或进度条来显示当前请求情况或进度。这种界面都会存在这样一个问题，在请求较慢时，用户手动退出界面，这时候需要去除加载栏。
 当然可以依次在每个界面的viewWillDisappear方法中添加去除方法，但如果类似的界面过多，一味的复制粘贴也不是方法。这时候就能体现Method Swizzling的作用了，我们可以替换系统的viewWillDisappear方法，使得每当执行该方法时即自动去除加载栏。
 
 代码如下，这样就不用考虑界面是否移除加载栏的问题了。补充一点，通常我们也会在生命周期方法中设置默认界面背景颜色，因若背景颜色默认为透明对App的性能也有一定影响，这大家可以在UIKit性能优化那篇文章中查阅。但类似该类操作也可以书写在通用类中，所以具体使用还要靠自己定夺。
 */

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(viewWillAppear:) bySwizzledSelector:@selector(sure_viewWillDisappear:)];
    });
}

- (void)sure_viewWillDisappear:(BOOL)animated {
    [self sure_viewWillDisappear:animated];
    
    //[SVProgressHUD dismiss];
    NSLog(@"sure_viewWillDisappear: do something eg: [hud dismiss]");
}

/**
 补充知识点
 
 为什么方法交换调用在+load方法中？
 
 在Objective-C runtime会自动调用两个类方法，分别为+load与+ initialize。+load 方法是在类被加载的时候调用的，也就是一定会被调用。而+initialize方法是在类或它的子类收到第一条消息之前被调用的，这里所指的消息包括实例方法和类方法的调用。也就是说+initialize方法是以懒加载的方式被调用的，如果程序一直没有给某个类或它的子类发送消息，那么这个类的+initialize方法是永远不会被调用的。此外+load方法还有一个非常重要的特性，那就是子类、父类和分类中的+load方法的实现是被区别对待的。换句话说在 Objective-C runtime自动调用+load方法时，分类中的+load方法并不会对主类中的+load方法造成覆盖。综上所述，+load 方法是实现 Method Swizzling 逻辑的最佳“场所”。如需更深入理解，可参考Objective-C 深入理解 +load 和 +initialize。
        http://www.jianshu.com/p/872447c6dc3f
 为什么方法交换要在dispatch_once中执行？
 
 方法交换应该要线程安全，而且保证在任何情况下（多线程环境，或者被其他人手动再次调用+load方法）只交换一次，防止再次调用又将方法交换回来。除非只是临时交换使用，在使用完成后又交换回来。 最常用的解决方案是在+load方法中使用dispatch_once来保证交换是安全的。之前有读者反馈+load方法本身即为线程安全，为什么仍需添加dispatch_once，其原因就在于+load方法本身无法保证其中代码只被执行一次。
 为什么没有发生死循环？
 
 一定有很多读者有疑惑，为什么sure_viewWillDisappear方法中的代码没有发生递归死循环。其原因很简单，因为方法已经执行过交换，调用[self sure_viewWillDisappear:animated]本质是在调用原有方法viewWillDisappear，反而如果我们在方法中调用[self viewWillDisappear:animated]才真的会发生死循环。是不是很绕？仔细看看。
 */

@end
