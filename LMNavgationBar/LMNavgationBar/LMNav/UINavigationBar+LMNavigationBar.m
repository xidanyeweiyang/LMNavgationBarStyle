//
//  UINavigationBar+LMNavigationBar.m
//  LMDuanZi
//
//  Created by 刘明 on 17/3/13.
//  Copyright © 2017年 刘明. All rights reserved.
//  简书地址:http://www.jianshu.com/p/60668e17ba47
//  GitHub地址:https://github.com/xidanyeweiyang/LMNavgationBarStyle


#import "UINavigationBar+LMNavigationBar.h"
#import <objc/runtime.h>

static char const *coverViewKey;

@implementation UINavigationBar (LMNavigationBar)

- (void)lm_setNavgationBarBackgroundColor:(UIColor *)color{
    
    if (!self.coverView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.coverView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + 20)];
        self.coverView.userInteractionEnabled = YES;
        self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.coverView atIndex:0];
    }
    
    self.coverView.backgroundColor = color;
}


- (void)lm_setNavgationBarBackgroundAlpha:(CGFloat)alpha{
    
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
       
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    
    titleView.alpha = alpha;
    
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
        }
//        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
//            obj.alpha = alpha;
//        }
    }];

}


- (void)setCoverView:(UIView *)coverView{
    
    objc_setAssociatedObject(self, coverViewKey, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)coverView{
    
    return objc_getAssociatedObject(self, coverViewKey);
}

- (void)lm_resetNavgation{
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self lm_setNavgationBarBackgroundAlpha:1];
    [self.coverView removeFromSuperview];
    self.coverView = nil;
}

- (void)lm_setTranslationY:(CGFloat)translationY {
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

// 显示导航栏下面的分割线
- (void)lm_showNavigationBarBottomLineView{
    
    [self setShadowImage:nil];
}

// 隐藏导航栏下面的分割线
- (void)lm_hiddenNavigationBarBottomLineView{
    
    [self setShadowImage:[[UIImage alloc] init]];
}

@end
