//
//  UINavigationBar+LMNavigationBar.h
//  LMDuanZi
//
//  Created by 刘明 on 17/3/13.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LMNavigationBar)


/**
 设置导航栏背景色

 @param color 背景色
 */
- (void)lm_setNavgationBarBackgroundColor:(UIColor *)color;


/**
 设置导航栏透明度

 @param alpha 透明度
 */
- (void)lm_setNavgationBarBackgroundAlpha:(CGFloat)alpha;


/**
 设置导航栏位移

 @param translationY 位移
 */
- (void)lm_setTranslationY:(CGFloat)translationY;
/**
 重置导航栏
 */
- (void)lm_resetNavgation;

/**
 显示导航栏下面的分割线
 */
- (void)lm_showNavigationBarBottomLineView;

/**
 隐藏导航栏下面的分割线
 */
- (void)lm_hiddenNavigationBarBottomLineView;

@end
