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
#import "ScreenUtil.h"

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
        //修改头像
        [self changeHeadIcon];

        [self.view addSubview:({
            UILabel *userNameLabel = [[UILabel alloc] initWithFrame:UIRect(181, STATUSBAR_HEIGHT + 44 + 74, 149, 24)];
            userNameLabel.font = [UIFont systemFontOfSize:UI(20)];
            userNameLabel.text = username;
            userNameLabel.textColor = [UIColor whiteColor];
            userNameLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
            [userNameLabel addGestureRecognizer:gesture1];
            userNameLabel;
        })];
        [self.view addSubview:({
            UILabel *info = [[UILabel alloc] initWithFrame:UIRect(181, STATUSBAR_HEIGHT + 44 + 106, 149, 20)];
            info.font = [UIFont systemFontOfSize:16];
            info.textColor = [UIColor whiteColor];
            info.text = @"个人信息 >";
            [info setFont:[UIFont systemFontOfSize:UI(17)]];
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
    int height = 250;
    if(STATUSBAR_HEIGHT == 44){
        height = 225;
    }
    //1 顶部背景色
    UIView *topView = [[UIView alloc] initWithFrame:UIRect(0, STATUSBAR_HEIGHT+44, 414, height)];
    topView.backgroundColor = [UIColor colorWithRGB:0x5abce3 lpha:0.9];

    [self.view addSubview:topView];

    //2 头像
    _headIcon = [[UIImageView alloc] init];
    _headIcon.frame = UIRect(34, STATUSBAR_HEIGHT+44 + 45, 122, 122);
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
    _loginBtn.frame = UIRect(175, STATUSBAR_HEIGHT+44 + 60, 115, 70);
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:UI(20)];
    [_loginBtn setTitle:@"登入/注册" forState:UIControlStateNormal];

    [self.view addSubview:_loginBtn];

    //4 离线地图box
    UIImageView *map = [[UIImageView alloc] initWithFrame:UIRect(20, 336.5, 30, 30)];
    [map setImage:[UIImage imageNamed:@"map_download"]];

    UILabel *mapLable = [[UILabel alloc] initWithFrame:UIRect(75, 336, 110, 30)];
    [mapLable setText:@"离线地图"];
    [mapLable setFont:[UIFont systemFontOfSize:UI(17)]];

    UIImageView *goto_map = [[UIImageView alloc] initWithFrame:UIRect(370, 340, 20, 20)];
    [goto_map setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_map = [[UIView alloc] initWithFrame:UIRect(0, 380, 414, 15)];
    spacing_map.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:map];
    [self.view addSubview:mapLable];
    [self.view addSubview:goto_map];
    [self.view addSubview:spacing_map];

    //5 我的反馈box
    UIImageView *feedback = [[UIImageView alloc] initWithFrame:UIRect(20, 412.5, 30, 30)];
    [feedback setImage:[UIImage imageNamed:@"feedback_info"]];

    UILabel *feedbackLable = [[UILabel alloc] initWithFrame:UIRect(75, 413, 110, 30)];
    [feedbackLable setText:@"我的反馈"];
    [feedbackLable setFont:[UIFont systemFontOfSize:UI(17)]];


    UIImageView *goto_feedback = [[UIImageView alloc] initWithFrame:UIRect(370, 417.5, 20, 20)];
    [goto_feedback setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_feedback = [[UIView alloc] initWithFrame:UIRect(0, 457, 414, 2)];
    spacing_feedback.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:feedback];
    [self.view addSubview:feedbackLable];
    [self.view addSubview:goto_feedback];
    [self.view addSubview:spacing_feedback];

    //6 我的收藏box
    UIImageView *collection = [[UIImageView alloc] initWithFrame:UIRect(20, 471, 30, 30)];
    [collection setImage:[UIImage imageNamed:@"collection"]];

    UILabel *collectionLable = [[UILabel alloc] initWithFrame:UIRect(75, 475, 110, 30)];
    [collectionLable setText:@"我的收藏"];
    [collectionLable setFont:[UIFont systemFontOfSize:UI(17)]];

    UIImageView *goto_collection = [[UIImageView alloc] initWithFrame:UIRect(370, 480.5, 20, 20)];
    [goto_collection setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_collection = [[UIView alloc] initWithFrame:UIRect(0, 516, 414, 15)];
    spacing_collection.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:collection];
    [self.view addSubview:collectionLable];
    [self.view addSubview:goto_collection];
    [self.view addSubview:spacing_collection];

    //7 帮助中心box
    UIImageView *help = [[UIImageView alloc] initWithFrame:UIRect(20, 555, 30, 30)];
    [help setImage:[UIImage imageNamed:@"help"]];

    UILabel *helpLable = [[UILabel alloc] initWithFrame:UIRect(75, 555, 110, 30)];
    [helpLable setText:@"帮助中心"];
    [helpLable setFont:[UIFont systemFontOfSize:UI(17)]];

    UIImageView *goto_help = [[UIImageView alloc] initWithFrame:UIRect(369, 561.5, 20, 20)];
    [goto_help setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_help = [[UIView alloc] initWithFrame:UIRect(0, 600, 414, 2)];
    spacing_help.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:help];
    [self.view addSubview:helpLable];
    [self.view addSubview:goto_help];
    [self.view addSubview:spacing_help];

    //8 设置中心box
    UIImageView *setting = [[UIImageView alloc] initWithFrame:UIRect(20, 618, 30, 30)];
    [setting setImage:[UIImage imageNamed:@"set"]];

    UILabel *settingLable = [[UILabel alloc] initWithFrame:UIRect(75, 614, 109, 44)];
    [settingLable setText:@"设置中心"];
    [settingLable setFont:[UIFont systemFontOfSize:UI(17)]];

    UIImageView *goto_setting = [[UIImageView alloc] initWithFrame:UIRect(370, 621, 20, 20)];
    [goto_setting setImage:[UIImage imageNamed:@"goto_30"]];

    UIView *spacing_setting = [[UIView alloc] initWithFrame:UIRect(0, 671, 414, 300)];
    spacing_setting.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

    [self.view addSubview:setting];
    [self.view addSubview:settingLable];
    [self.view addSubview:goto_setting];
    [self.view addSubview:spacing_setting];

    //增加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLogin)];
    [_loginBtn addGestureRecognizer:tapGesture];
}

#pragma mark --改变头像
- (void)changeHeadIcon{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *account = [user objectForKey:@"account"];
    NSString *picturePath = [self getPicturePathWithAccount:account];
    _headIcon.image = [[UIImage alloc] initWithContentsOfFile:picturePath];
}
//获取图片在沙盒中储存的地址
- (NSString *)getPicturePathWithAccount:(NSString *)account{
    //保存文件到沙盒
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoty = [paths lastObject];
    //获取最终图片文件存储地址
    NSString *picturePath = [documentsDirectoty stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",account]];
     NSLog(@"图片地址::%@",picturePath);
    return picturePath;
}

#pragma mark --点击事件
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
                UILabel *userNameLabel = [[UILabel alloc] initWithFrame:UIRect(181, STATUSBAR_HEIGHT+44 + 74, 149, 24)];
                userNameLabel.font = [UIFont systemFontOfSize:UI(20)];
                userNameLabel.text = username;
                userNameLabel.textColor = [UIColor whiteColor];
                userNameLabel.userInteractionEnabled = YES;
                UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoUserInfo)];
                [userNameLabel addGestureRecognizer:gesture1];
                userNameLabel;
            })];
            [weakSelf.view addSubview:({
                UILabel *info = [[UILabel alloc] initWithFrame:UIRect(181, STATUSBAR_HEIGHT+44 + 106, 149, 20)];
                info.font = [UIFont systemFontOfSize:UI(16)];
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
