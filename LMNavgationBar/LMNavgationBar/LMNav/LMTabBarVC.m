//
//  LMTabBarVC.m
//  Cofco
//
//  Created by 刘明 on 16/7/22.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "LMTabBarVC.h"
#import "ViewController.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "LMMainNavigationController.h"

@interface LMTabBarVC ()

@end

@implementation LMTabBarVC

+ (instancetype)sharedTaBarVC{
    
    static dispatch_once_t onceToken;
    
    static LMTabBarVC *tabBar;

    dispatch_once(&onceToken, ^{
        
        tabBar = [[LMTabBarVC alloc]init];
        
    });
 
    return tabBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVC];

}


- (void)setTabBarType:(NSString *)tabBarType{
    
    _tabBarType = tabBarType;
    
}
- (void)setupChildVC {
    
    //待办

    ViewController *needVC = [ViewController new];
    LMMainNavigationController *viewController1 = [self setupTabBarChildVC:@"下拉放大" andWithVC:needVC];

    
    ViewController2 *aleadyVC = [ViewController2 new];
    LMMainNavigationController *viewController2 = [self setupTabBarChildVC:@"导航栏渐变" andWithVC:aleadyVC];
    
    ViewController3 *impressionSalesVC = [ViewController3 new];

    LMMainNavigationController *viewController3 = [self setupTabBarChildVC:@"导航栏上移" andWithVC:impressionSalesVC];
    
    self.viewControllers = @[viewController1,viewController2,viewController3];



    
}

- (LMMainNavigationController *)setupTabBarChildVC:(NSString *)tittle andWithVC:(UIViewController *)viewController{
    
//    UIViewController *vcs = (UIViewController *)NSClassFromString(tittle);
    LMMainNavigationController *vc = [[LMMainNavigationController alloc]initWithRootViewController:viewController];
    
    vc.tabBarItem.title = tittle;

    vc.title = tittle;
//    viewController.title = tittle;
    
    vc.tabBarItem.image = [UIImage imageNamed:tittle];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@-选中",tittle]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    viewController.title = tittle;

    return vc;
}

- (void)setLastSelectedIndex:(NSInteger)lastSelectedIndex{
    
    _lastSelectedIndex = lastSelectedIndex;
    [self setSelectedIndex:lastSelectedIndex];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex
{
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex && selectedIndex != 3) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
        NSLog(@"1 OLD:%ld , NEW:%ld",self.lastSelectedIndex,selectedIndex);
    }
    
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    if (tabIndex != self.selectedIndex && tabIndex != 3) {
        //设置最近一次变更
        _lastSelectedIndex = self.selectedIndex;
        NSLog(@"2 OLD:%ld , NEW:%ld",self.lastSelectedIndex,tabIndex);
    }
    
//    if (tabIndex == 3) {
//        
//        LMCollaborativeMIdpointsDetialViewController *vc = [[LMCollaborativeMIdpointsDetialViewController alloc] init];
//        
//        [self presentViewController:vc animated:YES completion:nil];
//        
////        LMNav *nav = [[LMNav alloc] initWithRootViewController:vc];
////
////        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
////        
////        app.window.rootViewController = nav;
//
//    }
    
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
