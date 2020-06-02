//
//  MineViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/20.
//  Copyright © 2020 chen. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "UIColor+TransformColor.h"
#import "PersonalInfoViewController.h"
#import <SDWebImage/SDWebImage.h>

#define topbarHeight 88

@interface MineViewController ()

@property (nonatomic, strong, readwrite) UIButton *loginBtn;
@property (nonatomic, strong, readwrite) UIImageView *headIcon;

@end

@implementation MineViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"mine"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"mine_selected"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark UIViewController生命周期
- (void)viewWillAppear:(BOOL)animated {
    [self checkIsLogined];
}


//检查是否已经登入过账号，根据不同的登入情况选择显示不同的view
- (void)checkIsLogined {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:@"username"];
    if (username && ![username isEqualToString:@""]) { //已登入账号
        [self initView];
        //移除之前的登入注册view
        [self.loginBtn removeFromSuperview];

        [self.view addSubview:({
            UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(181, topbarHeight + 74, 149, 24)];
            userNameLabel.font = [UIFont systemFontOfSize:20];
            userNameLabel.text = username;
            userNameLabel.textColor = [UIColor whiteColor];
            userNameLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
            [userNameLabel addGestureRecognizer:gesture1];
            userNameLabel;
        })];
        [self.view addSubview:({
            UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(181, topbarHeight + 106, 149, 20)];
            info.font = [UIFont systemFontOfSize:16];
            info.textColor = [UIColor whiteColor];
            info.text = @"个人信息 >";
            info.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
            [info addGestureRecognizer:gesture2];
            info;
        })];
//        //头像
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *headUrl = [userDefaults objectForKey:@"headURL"];
//        NSLog(@"%@",headUrl);
//        [_headIcon sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:[UIImage imageNamed:@"headIcon"]];
    } else {
        [self initView];
    }
}

//初始化未登入时的界面
- (void)initView {
    //1 顶部背景色
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, topbarHeight, 414, 241)];
    topView.backgroundColor = [UIColor colorWithRGB:0x5abce3 lpha:0.9];

    [self.view addSubview:topView];

    //2 头像
    _headIcon = [[UIImageView alloc] init];
    _headIcon.frame = CGRectMake(34, topbarHeight + 45, 122, 122);
    _headIcon.image =  [UIImage imageNamed:@"headIcon"];

    //设置圆角半径为方形边长一半
    [_headIcon.layer setCornerRadius:CGRectGetHeight([_headIcon bounds]) / 2];
    [_headIcon.layer setMasksToBounds:YES];

    //设置边框宽度和颜色
    [_headIcon.layer setBorderWidth:1];
    [_headIcon.layer setBorderColor:[[UIColor whiteColor] CGColor]];

    [self.view addSubview:_headIcon];

    //3 登入注册
    _loginBtn = [[UIButton alloc] init];
    _loginBtn.frame = CGRectMake(175, topbarHeight + 60, 115, 70);
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_loginBtn setTitle:@"登入/注册" forState:UIControlStateNormal];

    [self.view addSubview:_loginBtn];

    //4 离线地图box
    UIImageView *map = [[UIImageView alloc] initWithFrame:CGRectMake(20, 366.5, 30, 30)];
    [map setImage:[UIImage imageNamed:@"map_download"]];

    UILabel *mapLable = [[UILabel alloc] initWithFrame:CGRectMake(75, 366, 110, 30)];
    [mapLable setText:@"离线地图"];

    UIImageView *goto_map = [[UIImageView alloc] initWithFrame:CGRectMake(370, 370, 20, 20)];
    [goto_map setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_map = [[UIView alloc] initWithFrame:CGRectMake(0, 410, 414, 20)];
    spacing_map.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:map];
    [self.view addSubview:mapLable];
    [self.view addSubview:goto_map];
    [self.view addSubview:spacing_map];

    //5 我的反馈box
    UIImageView *feedback = [[UIImageView alloc] initWithFrame:CGRectMake(20, 442.5, 30, 30)];
    [feedback setImage:[UIImage imageNamed:@"feedback_info"]];

    UILabel *feedbackLable = [[UILabel alloc] initWithFrame:CGRectMake(75, 443, 110, 30)];
    [feedbackLable setText:@"我的反馈"];

    UIImageView *goto_feedback = [[UIImageView alloc] initWithFrame:CGRectMake(370, 447.5, 20, 20)];
    [goto_feedback setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_feedback = [[UIView alloc] initWithFrame:CGRectMake(0, 487, 414, 1)];
    spacing_feedback.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:feedback];
    [self.view addSubview:feedbackLable];
    [self.view addSubview:goto_feedback];
    [self.view addSubview:spacing_feedback];

    //6 我的收藏box
    UIImageView *collection = [[UIImageView alloc] initWithFrame:CGRectMake(20, 501, 30, 30)];
    [collection setImage:[UIImage imageNamed:@"collection"]];

    UILabel *collectionLable = [[UILabel alloc] initWithFrame:CGRectMake(75, 505, 110, 30)];
    [collectionLable setText:@"我的收藏"];

    UIImageView *goto_collection = [[UIImageView alloc] initWithFrame:CGRectMake(370, 510.5, 20, 20)];
    [goto_collection setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_collection = [[UIView alloc] initWithFrame:CGRectMake(0, 546, 414, 20)];
    spacing_collection.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:collection];
    [self.view addSubview:collectionLable];
    [self.view addSubview:goto_collection];
    [self.view addSubview:spacing_collection];

    //7 帮助中心box
    UIImageView *help = [[UIImageView alloc] initWithFrame:CGRectMake(20, 585, 30, 30)];
    [help setImage:[UIImage imageNamed:@"help"]];

    UILabel *helpLable = [[UILabel alloc] initWithFrame:CGRectMake(75, 585, 110, 30)];
    [helpLable setText:@"帮助中心"];

    UIImageView *goto_help = [[UIImageView alloc] initWithFrame:CGRectMake(369, 591.5, 20, 20)];
    [goto_help setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_help = [[UIView alloc] initWithFrame:CGRectMake(0, 630, 414, 1)];
    spacing_help.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:help];
    [self.view addSubview:helpLable];
    [self.view addSubview:goto_help];
    [self.view addSubview:spacing_help];

    //8 设置中心box
    UIImageView *setting = [[UIImageView alloc] initWithFrame:CGRectMake(20, 648, 30, 30)];
    [setting setImage:[UIImage imageNamed:@"set"]];

    UILabel *settingLable = [[UILabel alloc] initWithFrame:CGRectMake(75, 644, 109, 44)];
    [settingLable setText:@"设置中心"];

    UIImageView *goto_setting = [[UIImageView alloc] initWithFrame:CGRectMake(370, 651, 20, 20)];
    [goto_setting setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_setting = [[UIView alloc] initWithFrame:CGRectMake(0, 701, 414, 112)];
    spacing_setting.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:setting];
    [self.view addSubview:settingLable];
    [self.view addSubview:goto_setting];
    [self.view addSubview:spacing_setting];

    //增加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLogin)];
    [_loginBtn addGestureRecognizer:tapGesture];
}

#pragma mark 点击事件
//跳转登入账号界面
- (void)gotoLogin {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    //避免循环引用，造成内存泄漏
    __weak typeof(self) weakSelf = self;
    //设置block
    [loginViewController setLoginState:^(BOOL isLogin, NSString *username) {
        if (isLogin) { //已经登入
            //移除之前的登入注册view
            [weakSelf.loginBtn removeFromSuperview];

            [weakSelf.view addSubview:({
                UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(181, topbarHeight + 74, 149, 24)];
                userNameLabel.font = [UIFont systemFontOfSize:20];
                userNameLabel.text = username;
                userNameLabel.textColor = [UIColor whiteColor];
                userNameLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
                [userNameLabel addGestureRecognizer:gesture1];
                userNameLabel;
            })];
            [weakSelf.view addSubview:({
                UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(181, topbarHeight + 106, 149, 20)];
                info.font = [UIFont systemFontOfSize:16];
                info.textColor = [UIColor whiteColor];
                info.text = @"个人信息 >";
                info.userInteractionEnabled = YES;
                UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
                [info addGestureRecognizer:gesture2];
                info;
            })];
        }
    }];
    [self.navigationController pushViewController:loginViewController animated:YES];
}

//前往个人信息中心
- (void)gotoUserInfo {
    PersonalInfoViewController *personalInfoPage = [[PersonalInfoViewController alloc] init];
    [self.navigationController pushViewController:personalInfoPage animated:YES];
}

@end
