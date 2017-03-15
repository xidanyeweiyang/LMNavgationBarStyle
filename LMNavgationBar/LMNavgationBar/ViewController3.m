//
//  ViewController3.m
//  LMNavgationBar
//
//  Created by 刘明 on 17/3/14.
//  Copyright © 2017年 刘明. All rights reserved.
//  简书地址:http://www.jianshu.com/p/60668e17ba47
//  GitHub地址:https://github.com/xidanyeweiyang/LMNavgationBarStyle


#import "ViewController3.h"
#import "UINavigationBar+LMNavigationBar.h"
#import "UIBarButtonItem+LMBarButtonItem.h"

#define kBackImageHeight 200
#define navHeight 44 //上推留下的高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController3 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController3

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //防止因为标签二设置,影响nav的栈;
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    [self.navigationController.navigationBar lm_setNavgationBarBackgroundColor:[color colorWithAlphaComponent:1]];

}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar lm_resetNavgation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupNav];
    
}

- (void)setupNav{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
//    [self.navigationController.navigationBar lm_setNavgationBarBackgroundColor:[UIColor clearColor]];
    
}

- (void)setupUI{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    
    imageView.frame = CGRectMake(0, -kBackImageHeight, kScreenWidth, kBackImageHeight);
    
    [self.tableView insertSubview:imageView atIndex:0];
    
    [self.view addSubview:self.tableView];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y + kBackImageHeight;
    
    NSLog(@"%f",offsetY);
    
    if (offsetY > 0) {
        
        if (offsetY < navHeight) {
            
            [self.navigationController.navigationBar lm_setTranslationY:-offsetY];
            [self.navigationController.navigationBar lm_setNavgationBarBackgroundAlpha:1-(offsetY/navHeight)];
            
        }else{
         
            [self.navigationController.navigationBar lm_setTranslationY:-navHeight];
            [self.navigationController.navigationBar lm_setNavgationBarBackgroundAlpha:0];
        }
        
    }else{
        
        [self.navigationController.navigationBar lm_setTranslationY:0];
        [self.navigationController.navigationBar lm_setNavgationBarBackgroundAlpha:1];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];

    }

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.item % 2 == 1) {
        
        cell.backgroundColor = [UIColor lightGrayColor];
    }else{
        
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"indexPath.row == %zd",indexPath.row];
    
    return cell;
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -navHeight, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(kBackImageHeight, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
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
