//
//  LocationViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/20.
//  Copyright © 2020 chen. All rights reserved.
//

#import "LocationViewController.h"
#import "ViewPointViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (instancetype)init{
    self = [super init];
    if(self){
        self.view.backgroundColor = [UIColor whiteColor];
        
        
        
        self.tabBarItem.title = @"目的地";
        self.tabBarItem.image = [UIImage imageNamed:@"location"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"location_selected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

#pragma mark - 初始化
- (void)initView{
    //1 上海
    UIImageView *shanghai_img = [[UIImageView alloc] initWithFrame:CGRectMake(67, 111, 280, 170)];
    [shanghai_img setImage:[UIImage imageNamed:@"shang_hai"]];
    shanghai_img.layer.cornerRadius = 10;
    shanghai_img.layer.masksToBounds = YES;
    
    UILabel *shanghai_lable = [[UILabel alloc] initWithFrame:CGRectMake(186, 285, 45, 20)];
    shanghai_lable.text = @"上海";
    
    shanghai_img.userInteractionEnabled = YES; //需要设置，否则无法响应点击事件
    
    [self.view addSubview:shanghai_img];
    [self.view addSubview:shanghai_lable];
    
    //2 重庆
    UIImageView *chongqi_img = [[UIImageView alloc] initWithFrame:CGRectMake(67, 351, 280, 170)];
    [chongqi_img setImage:[UIImage imageNamed:@"chongqi"]];
    chongqi_img.layer.cornerRadius = 10;
    chongqi_img.layer.masksToBounds = YES;
    
    UILabel *chongqi_lable = [[UILabel alloc] initWithFrame:CGRectMake(186, 527, 45, 20)];
    chongqi_lable.text = @"重庆";
    
    chongqi_img.userInteractionEnabled = YES; //需要设置，否则无法响应点击事件
    
    [self.view addSubview:chongqi_img];
    [self.view addSubview:chongqi_lable];
    
    //3 北京
    UIImageView *beijing_img = [[UIImageView alloc] initWithFrame:CGRectMake(67, 589, 280, 170)];
    [beijing_img setImage:[UIImage imageNamed:@"beijing"]];
    beijing_img.layer.cornerRadius = 10;
    beijing_img.layer.masksToBounds = YES;
    
    UILabel *beijing_lable = [[UILabel alloc] initWithFrame:CGRectMake(186, 762, 45, 20)];
    beijing_lable.text = @"北京";
    
    beijing_img.userInteractionEnabled = YES; //需要设置，否则无法响应点击事件
    
    [self.view addSubview:beijing_img];
    [self.view addSubview:beijing_lable];


    
    //增加点击事件(一个手势只能赋值给一个view对象,或者更多？)
    UITapGestureRecognizer *shanghaiGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoShanghai)];
    [shanghai_img addGestureRecognizer:shanghaiGesture];
    
    UITapGestureRecognizer *chongqiGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoChongqi)];
    [chongqi_img addGestureRecognizer:chongqiGesture];
    
    UITapGestureRecognizer *beijingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBeijing)];
    [beijing_img addGestureRecognizer:beijingGesture];
 
    
}

#pragma mark 点击事件

- (void)gotoShanghai{
    ViewPointViewController *controller = [[ViewPointViewController alloc] init];
    [controller setNavigationTitle:@"上海"];
    [controller initShanghaiData];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoChongqi{
    ViewPointViewController *controller = [[ViewPointViewController alloc] init];
    [controller setNavigationTitle:@"重庆"];
    [controller initChongqingData];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoBeijing{
    ViewPointViewController *controller = [[ViewPointViewController alloc] init];
    [controller setNavigationTitle:@"北京"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
