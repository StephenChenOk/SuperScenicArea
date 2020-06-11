//
//  LocationViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/20.
//  Copyright © 2020 chen. All rights reserved.
//

#import "LocationViewController.h"
#import "ViewPointViewController.h"
#import "ScreenUtil.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (instancetype)init {
    self = [super init];
    if (self) {
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
- (void)initView {
    NSInteger contentHeight = 774;
    [self.view addSubview:({
        UIScrollView *scorllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

        //1 重庆
        [scorllView addSubview:({
            UIImageView *chongqi_img = [[UIImageView alloc] initWithFrame:UIRect(67, 36, 280, 170)];
            [chongqi_img setImage:[UIImage imageNamed:@"chongqi"]];
            chongqi_img.layer.cornerRadius = UI(10);
            chongqi_img.layer.masksToBounds = YES;

            chongqi_img.userInteractionEnabled = YES; //需要设置，否则无法响应点击事件
            UITapGestureRecognizer *chongqiGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoChongqi)];
            [chongqi_img addGestureRecognizer:chongqiGesture];

            chongqi_img;
        })];
        [scorllView addSubview:({
            UILabel *chongqi_lable = [[UILabel alloc] initWithFrame:UIRect(165, 200, 85, 37)];
            chongqi_lable.text = @"重庆";
            chongqi_lable.font = [UIFont systemFontOfSize:UI(18)];
            chongqi_lable.textAlignment = NSTextAlignmentCenter;
            chongqi_lable;
        })];

        //2 上海
        [scorllView addSubview:({
            UIImageView *shanghai_img = [[UIImageView alloc] initWithFrame:UIRect(67, 274, 280, 170)];
            [shanghai_img setImage:[UIImage imageNamed:@"shang_hai"]];
            shanghai_img.layer.cornerRadius = UI(10);
            shanghai_img.layer.masksToBounds = YES;

            shanghai_img.userInteractionEnabled = YES; //需要设置，否则无法响应点击事件
            UITapGestureRecognizer *shanghaiGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoShanghai)];
            [shanghai_img addGestureRecognizer:shanghaiGesture];

            shanghai_img;
        })];
        [scorllView addSubview:({
            UILabel *shanghai_lable = [[UILabel alloc] initWithFrame:UIRect(165, 437, 85, 37)];
            shanghai_lable.text = @"上海";
            shanghai_lable.font = [UIFont systemFontOfSize:UI(18)];
            shanghai_lable.textAlignment = NSTextAlignmentCenter;
            shanghai_lable;
        })];

        //3 北京
        [scorllView addSubview:({
            UIImageView *beijing_img = [[UIImageView alloc] initWithFrame:UIRect(67, 514, 280, 170)];
            [beijing_img setImage:[UIImage imageNamed:@"beijing"]];
            beijing_img.layer.cornerRadius = UI(10);
            beijing_img.layer.masksToBounds = YES;

            beijing_img.userInteractionEnabled = YES;    //需要设置，否则无法响应点击事件
            UITapGestureRecognizer *beijingGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoBeijing)];
            [beijing_img addGestureRecognizer:beijingGesture];

            beijing_img;
        })];
        [scorllView addSubview:({
            UILabel *beijing_lable = [[UILabel alloc] initWithFrame:UIRect(165, 679, 85, 37)];
            beijing_lable.text = @"北京";
            beijing_lable.textAlignment = NSTextAlignmentCenter;
            beijing_lable.font = [UIFont systemFontOfSize:UI(18)];

            //设置滚动的高度
            contentHeight = UI(687 + 37 + 20);

            beijing_lable;
        })];

        //设置scrollView内容的大小
        scorllView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.origin.y + contentHeight);

        scorllView;
    })];
}

#pragma mark 点击事件

- (void)gotoShanghai {
    ViewPointViewController *controller = [[ViewPointViewController alloc] init];
    [controller setNavigationTitle:@"上海"];
    [controller initViewPointDataWithCity:@"上海"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoChongqi {
    ViewPointViewController *controller = [[ViewPointViewController alloc] init];
    [controller setNavigationTitle:@"重庆"];
    [controller initViewPointDataWithCity:@"重庆"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoBeijing {
    ViewPointViewController *controller = [[ViewPointViewController alloc] init];
    [controller setNavigationTitle:@"北京"];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
