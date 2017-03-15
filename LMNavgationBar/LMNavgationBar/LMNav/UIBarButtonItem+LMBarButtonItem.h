//
//  UIBarButtonItem+LMBarButtonItem.h
//  LMDuanZi
//
//  Created by 刘明 on 17/3/9.
//  Copyright © 2017年 刘明. All rights reserved.
//  简书地址:http://www.jianshu.com/p/60668e17ba47
//  GitHub地址:https://github.com/xidanyeweiyang/LMNavgationBarStyle


#import <UIKit/UIKit.h>

typedef void(^LMButtonTouchBlock)();
@interface UIBarButtonItem (LMBarButtonItem)

/**
 创建一个带图片的barButtonItem
 
 @param imageName 图片名
 @param touchBlock 响应事件
 @return 带图片的barButtonItem
 */
+ (instancetype)lm_barButtonWithImage:(NSString *)imageName touchBlock:(LMButtonTouchBlock)touchBlock;


/**
 创建一个带文本的barButtonItem

 @param title 文本
 @param touchBlock 响应事件
 @return 带文本的barButtonItem
 */
+ (instancetype)lm_barButtonWithTitle:(NSString *)title touchBlock:(LMButtonTouchBlock)touchBlock;

@end
