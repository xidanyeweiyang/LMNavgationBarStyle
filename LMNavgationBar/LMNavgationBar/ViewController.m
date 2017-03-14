//
//  ViewController.m
//  LMNavgationBar
//
//  Created by 刘明 on 17/3/14.
//  Copyright © 2017年 刘明. All rights reserved.
//

#import "ViewController.h"
#import "UINavigationBar+LMNavigationBar.h"
#import "UIBarButtonItem+LMBarButtonItem.h"

#define kBackImageHeight 280
#define navHeight 64 //上推留下的高度
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface HeadView:UIView

@property (weak, nonatomic) UIImageView * backgroundView;
@property (weak, nonatomic) UIImageView * headView;
@property (weak, nonatomic) UILabel * signLabel;

@end

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame backgroundView:(NSString *)name headView:(NSString *)headImgName headViewWidth:(CGFloat)width signLabel:(NSString *)signature
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView * backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -navHeight, frame.size.width, frame.size.height)];
        UIImage * image = [UIImage imageNamed:name];
        UIImage * newImg = [self image:image byScalingToSize:self.bounds.size];
        backgroundView.image = newImg;
        backgroundView.clipsToBounds = YES;
        [self addSubview:backgroundView];
        _backgroundView = backgroundView;
        
        UIImageView * headView = [[UIImageView alloc]initWithFrame:(CGRect){(frame.size.width - width) * 0.5,0.5 * (frame.size.height - width) - navHeight,width,width}];
        headView.layer.cornerRadius = width*0.5;
        headView.layer.masksToBounds = YES;
        headView.image = [UIImage imageNamed:headImgName];
        [self addSubview:headView];
        _headView = headView;
        
        UILabel * signLabel = [[UILabel alloc]initWithFrame:(CGRect){0,CGRectGetMaxY(headView.frame) ,self.bounds.size.width,40}];
        signLabel.text = signature;
        signLabel.textAlignment = NSTextAlignmentCenter;
        signLabel.textColor = [UIColor whiteColor];
        [self addSubview:signLabel];
        _signLabel = signLabel;
        
    }
    return self;
}

- (UIImage *)image:(UIImage*)image byScalingToSize:(CGSize)targetSize {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}
@end


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HeadView *headView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self setupNav];

}

- (void)setupUI{
    
    [self.view addSubview:self.tableView];
 
    [self.view addSubview:self.headView];

}


- (void)setupNav{
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem lm_barButtonWithTitle:@"返回" touchBlock:^{
        NSLog(@"不返回");
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem lm_barButtonWithTitle:@"跳转" touchBlock:^{
        NSLog(@"不跳转");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y + kBackImageHeight - navHeight - navHeight;
    
    if (offsetY <= 0) {
        
        self.headView.backgroundView.contentMode = UIViewContentModeScaleToFill;

        self.headView.backgroundView.frame = CGRectMake(offsetY*0.5,-navHeight, kScreenWidth-offsetY, kBackImageHeight-offsetY);
        
    }else if (offsetY < kBackImageHeight - navHeight - navHeight) {
        
        self.headView.backgroundView.contentMode = UIViewContentModeTop;

        CGFloat y = navHeight* offsetY/(kBackImageHeight-navHeight-navHeight)-navHeight;
        
        self.headView.backgroundView.frame = CGRectMake(0 ,y , kScreenWidth , kBackImageHeight -(navHeight + y) - offsetY);
        
        CGFloat width = offsetY*(40-(kScreenWidth / 4))/(kBackImageHeight-navHeight-navHeight)+(kScreenWidth / 4);
        self.headView.headView.frame =CGRectMake(0, 0, width,width);
        self.headView.headView.layer.cornerRadius = width*0.5;
        self.headView.headView.center = self.headView.backgroundView.center;
        self.headView.signLabel.frame =CGRectMake(0, CGRectGetMaxY(self.headView.headView.frame), kScreenWidth, 40);
        self.headView.signLabel.alpha = 1 - (offsetY*3 / (kBackImageHeight-navHeight-navHeight) /2);
        
    }else if(offsetY >= (kBackImageHeight-navHeight-navHeight)){
        
        self.headView.backgroundView.contentMode = UIViewContentModeTop;
        
        CGFloat y = navHeight* (kBackImageHeight-navHeight-navHeight)/(kBackImageHeight-navHeight-navHeight)-navHeight;
        
        self.headView.backgroundView.frame = CGRectMake(0 ,y , kScreenWidth , kBackImageHeight -(navHeight + y) - (kBackImageHeight-navHeight-navHeight));
        
        
        CGFloat width = (kBackImageHeight-navHeight-navHeight)*(40-(kScreenWidth / 4))/(kBackImageHeight-navHeight-navHeight)+(kScreenWidth / 4);
        self.headView.headView.frame =CGRectMake(0, 0, width,width);
        self.headView.headView.layer.cornerRadius =width*0.5;
        self.headView.headView.center = self.headView.backgroundView.center;
        
        self.headView.signLabel.frame =CGRectMake(0, CGRectGetMaxY(self.headView.headView.frame), kScreenWidth, 40);
        
        self.headView.signLabel.alpha = 1 - ((kBackImageHeight-navHeight-navHeight)*3 / (kBackImageHeight-navHeight-navHeight) /2);
        
    }
    
    
    
    
}


- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, navHeight, kScreenWidth, [UIScreen mainScreen].bounds.size.height- navHeight-navHeight)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.contentInset = UIEdgeInsetsMake(kBackImageHeight-navHeight-navHeight, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
     
- (HeadView *)headView{
    
    if (!_headView) {
        
        _headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kBackImageHeight) backgroundView:@"background.jpg" headView:@"headImg.jpg" headViewWidth:(CGFloat)(kScreenWidth / 4) signLabel:@"西单夜未央"];
    
        _headView.backgroundColor = [UIColor clearColor];
        _headView.userInteractionEnabled = YES;

    }
    
    return _headView;
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
