//
//  ViewController2.m
//  LMNavgationBar
//
//  Created by 刘明 on 17/3/14.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "ViewController2.h"
#import "UINavigationBar+LMNavigationBar.h"
#import "UIBarButtonItem+LMBarButtonItem.h"

#define kBackImageHeight 200
#define navHeight 64 //上推留下的高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController2

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.tableView];
    
    self.navigationController.navigationBar.translucent = YES;

}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar lm_resetNavgation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupNav];
    
}

- (void)setupNav{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem lm_barButtonWithTitle:@"假按钮" touchBlock:^{
        
        NSLog(@"点击了假按钮");
    }];
    
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem lm_barButtonWithTitle:@"跳转" touchBlock:^{
        
        NSLog(@"点击了跳转按钮");

    }];
    

}

- (void)setupUI{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景图"]];
    
    imageView.frame = CGRectMake(0, -kBackImageHeight, kScreenWidth, kBackImageHeight);
    
    [self.tableView insertSubview:imageView atIndex:0];
    
    [self.view addSubview:self.tableView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    
    CGFloat offsetY = scrollView.contentOffset.y + kBackImageHeight;
    
    NSLog(@"%f",offsetY);
    
    if (offsetY > navHeight) {
        
        CGFloat alpha = MIN(1, 1-((navHeight + navHeight - offsetY)/navHeight));
        
        [self.navigationController.navigationBar lm_setNavgationBarBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
    }else{
        
        [self.navigationController.navigationBar lm_setNavgationBarBackgroundColor:[color colorWithAlphaComponent:0]];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-navHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(kBackImageHeight, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
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
