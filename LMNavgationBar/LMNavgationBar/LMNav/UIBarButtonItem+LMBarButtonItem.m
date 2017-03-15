//
//  UIBarButtonItem+LMBarButtonItem.m
//  LMDuanZi
//
//  Created by 刘明 on 17/3/9.
//  Copyright © 2017年 刘明. All rights reserved.
//  简书地址:http://www.jianshu.com/p/60668e17ba47
//  GitHub地址:https://github.com/xidanyeweiyang/LMNavgationBarStyle


#import "UIBarButtonItem+LMBarButtonItem.h"
#import <objc/runtime.h>

static char *touchItemBlockKey = "touchItemBlockKey";
static char *touchButtonBlockKey = "touchBlockKey";

@interface UIBarButtonItem ()

@property (nonatomic, copy) LMButtonTouchBlock touchBlock;

@end

@implementation UIBarButtonItem (LMBarButtonItem)

/**
 创建一个带图片的barButtonItem
 
 @param imageName 图片名
 @param touchBlock 响应事件
 @return 带图片的barButtonItem
 */
+ (instancetype)lm_barButtonWithImage:(NSString *)imageName touchBlock:(LMButtonTouchBlock)touchBlock{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imageName) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    button.frame = (CGRect){CGPointZero, button.currentImage.size};
    
    [button addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(self, touchButtonBlockKey, touchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    //导航栏为什么只要自定义button 它的响应范围就变的很大?
    //不知道原理,只知道这样给Button添加一个父视图view能有效缩小button的响应范围
    UIView *btnView = [[UIView alloc] initWithFrame:button.bounds];
   
    btnView.bounds = CGRectOffset(btnView.bounds, -6, 0);

    [btnView addSubview:button];
    
    return  [[self alloc] initWithCustomView:btnView];
    
}


/**
 创建一个带文本的barButtonItem
 
 @param title 文本
 @param touchBlock 响应事件
 @return 带文本的barButtonItem
 */
+ (instancetype)lm_barButtonWithTitle:(NSString *)title touchBlock:(LMButtonTouchBlock)touchBlock{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(itemTouch:)];
    item.touchBlock = touchBlock;
    item.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1];
    return item;
}


+ (void)itemTouch:(UIBarButtonItem *)item{
    
    if (item.touchBlock) {
        
        item.touchBlock();
    }
    
}

- (void)setTouchBlock:(LMButtonTouchBlock)touchBlock{
    
    objc_setAssociatedObject(self, touchItemBlockKey, touchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LMButtonTouchBlock)touchBlock{
    
    return objc_getAssociatedObject(self, touchItemBlockKey);
}

+ (void)btnTouch:(id)sender{
    
    LMButtonTouchBlock block = objc_getAssociatedObject(self, touchButtonBlockKey);
    
    if (block) {
        
        block();
    }
}

@end
