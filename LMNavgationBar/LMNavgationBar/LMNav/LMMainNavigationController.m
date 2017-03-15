//
//  LMMainNavigationController.m
//  LMDuanZi
//
//  Created by 刘明 on 17/3/9.
//  Copyright © 2017年 刘明. All rights reserved.
//  简书地址:http://www.jianshu.com/p/60668e17ba47
//  GitHub地址:https://github.com/xidanyeweiyang/LMNavgationBarStyle


#import "LMMainNavigationController.h"

@interface LMMainNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation LMMainNavigationController

+ (void)initialize {
    // 设置为不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    // 设置导航栏背景颜色
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    // 设置导航栏标题文字颜色
    // 创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    color[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.32f green:0.36f blue:0.40f alpha:1];
    [[UINavigationBar appearance] setTitleTextAttributes:color];
    
    // 拿到整个导航控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1];
    // 设置字典的字体大小
    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    atts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1];
    // 将字典给item
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
    //取消横线
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak LMMainNavigationController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
        
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated == YES ){
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [btn setImage:[UIImage imageNamed:@"back_neihan"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
        btn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1];
        UIView *btnView = [[UIView alloc] initWithFrame:btn.bounds];
        [btnView addSubview:btn];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btnView];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftItem;
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    [self popViewControllerAnimated:YES];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES) {
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self  respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES) {
     
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        if (navigationController.childViewControllers.count == 1) {
            
            self.interactivePopGestureRecognizer.enabled = NO;
            
        }else
            
            self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    NSLog(@"child view count - %ld",navigationController.childViewControllers.count);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
