//
//  LoginViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/23.
//  Copyright © 2020 chen. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+TransformColor.h"
#import "RegisterViewController.h"
#import "UserUtil.h"

#import "User+CoreDataClass.h"
#import "User+CoreDataProperties.h"
#import "AppDelegate.h"

#define topbarHeight 88

@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *account;
@property (nonatomic, strong, readwrite) UITextField *password;
@property (nonatomic, strong, readwrite) UIButton *loginBtn;

@property (nonatomic, strong, readwrite) UserUtil *loginUtil;

@end

@implementation LoginViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];

        UILabel *titleView = [[UILabel alloc] init];
        titleView.text = @"登入";
        titleView.font = [UIFont systemFontOfSize:18];
        titleView.textColor = [UIColor colorWithRGB:0x286DD6 lpha:1];
        self.navigationItem.titleView = titleView;

        [self.view addSubview:({
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 88, 414, 241)];
            topView.backgroundColor = [UIColor colorWithRGB:0x5abce3 lpha:0.9];
            topView;
        })];
        [self.view addSubview:({
            UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(157, topbarHeight + 30, 100, 100)];
            [logo setImage:[UIImage imageNamed:@"scenery"]];
            logo;
        })];
        [self.view addSubview:({
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(108, topbarHeight + 148, 199, 29)];
            name.font = [UIFont systemFontOfSize:22];
            name.textColor = [UIColor whiteColor];
            name.text = @"Wisdom Scenic Spot";
            name;
        })];
        [self.view addSubview:({
            UIImageView *user = [[UIImageView alloc] initWithFrame:CGRectMake(72, 413.5, 25, 25)];
            [user setImage:[UIImage imageNamed:@"user"]];
            user;
        })];
        [self.view addSubview:({
            self.account = [[UITextField alloc] initWithFrame:CGRectMake(114, 411, 213, 34)];
            self.account.textColor = [UIColor lightGrayColor];
            self.account.font = [UIFont systemFontOfSize:15];
            self.account.placeholder = @"账号";
            self.account.borderStyle = UITextBorderStyleRoundedRect;//边框圆角
            self.account.delegate = self;
            self.account;
        })];
        [self.view addSubview:({
            UIImageView *lock = [[UIImageView alloc] initWithFrame:CGRectMake(72, 487.5, 25, 25)];
            [lock setImage:[UIImage imageNamed:@"lock"]];
            lock;
        })];
        [self.view addSubview:({
            self.password = [[UITextField alloc] initWithFrame:CGRectMake(114, 483, 213, 34)];
            self.password.textColor = [UIColor lightGrayColor];
            self.password.font = [UIFont systemFontOfSize:15];
            self.password.placeholder = @"密码";
            self.password.borderStyle = UITextBorderStyleRoundedRect;
            self.password.delegate = self;
            self.password;
        })];
        [self.view addSubview:({
            self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(72, 606, 267, 45)];
            self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            self.loginBtn.backgroundColor = [UIColor colorWithRGB:0x5abce3 lpha:0.9];
            [self.loginBtn setTitle:@"登入" forState:UIControlStateNormal];
            self.loginBtn.layer.cornerRadius = 10;
            self.loginBtn.layer.masksToBounds = YES;
            //增加点击事件(一个手势只能赋值给一个view对象,或者更多？)
            UITapGestureRecognizer *toRegisterGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
            [self.loginBtn addGestureRecognizer:toRegisterGesture];
            self.loginBtn;
        })];
        [self.view addSubview:({
            UILabel *toRegister = [[UILabel alloc] initWithFrame:CGRectMake(226, 670, 138, 31)];
            toRegister.font = [UIFont systemFontOfSize:14];
            toRegister.textColor = [UIColor lightGrayColor];
            toRegister.text = @"没有账号？选择注册";
            toRegister.userInteractionEnabled = YES;
            //增加点击事件(一个手势只能赋值给一个view对象,或者更多？)
            UITapGestureRecognizer *toRegisterGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toRegister)];
            [toRegister addGestureRecognizer:toRegisterGesture];
            toRegister;
        })];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _loginUtil = [[UserUtil alloc] init];
}

//进行登入
- (void)login {
    NSString *account = _account.text;
    NSString *password = _password.text;
    //1 账号存在且账号与密码对应
    if ([_loginUtil isUserExisted:account] && [_loginUtil isPwdCorrected:account andPwd:password]) {
        //2 用户信息
        NSString *username = @"";
        NSString *phoneNum = @"";
//        NSString *headUrl = @"";
        
        NSArray *users = [_loginUtil queryUserWithFilter:[NSString stringWithFormat:@"account = %@", account]];
        for (User *user in users) {
            if ([user.name isEqualToString:@"游客"]) {
                username = [NSString stringWithFormat:@"%@-%@", user.name, user.account];
            } else {
                username = user.name;
            }
            phoneNum = user.phoneNum;
//            headUrl = user.headURL;
        }
        //3 记录用户信息
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:account forKey:@"account"];
        [userDefault setObject:username forKey:@"username"];
        [userDefault setObject:phoneNum forKey:@"phoneNum"];
//        [userDefault setObject:headUrl forKey:@"headURL"];
        [userDefault synchronize];  //立即写入磁盘
        
        //4 登入成功，回传登入成功状态以及用户名
        _loginState(true, username);
        NSLog(@"登入成功");
        //5 结束当前界面
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//跳转注册界面
- (void)toRegister {
    UIViewController *registerViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

#pragma mark UITextFieldDelegate
//收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UIViewController生命周期
//视图已经消失
- (void)viewDidDisappear:(BOOL)animated {
    _account.text = @"";
    _password.text = @"";
    
}

//视图已经显示
- (void)viewDidAppear:(BOOL)animated {
    
}

@end
