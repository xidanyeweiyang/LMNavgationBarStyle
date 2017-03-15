//
//  LMTabBarVC.h
//  Cofco
//
//  Created by 刘明 on 16/7/22.
//  Copyright © 2016年 刘明. All rights reserved.
//  简书地址:http://www.jianshu.com/p/60668e17ba47
//  GitHub地址:https://github.com/xidanyeweiyang/LMNavgationBarStyle


#import <UIKit/UIKit.h>

@interface LMTabBarVC : UITabBarController

+ (instancetype)sharedTaBarVC;

@property (nonatomic, assign) NSInteger lastSelectedIndex;

@property (nonatomic, copy) NSString *tabBarType;

@end
