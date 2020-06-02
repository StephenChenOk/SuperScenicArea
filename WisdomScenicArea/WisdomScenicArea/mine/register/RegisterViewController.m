//
//  RegisterViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import "RegisterViewController.h"
#import "UIColor+TransformColor.h"
#import "UserUtil.h"

@interface RegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *account;
@property (nonatomic, strong, readwrite) UITextField *password;
@property (nonatomic, strong, readwrite) UITextField *confirmPassword;
@property (nonatomic, strong, readwrite) UIButton *registerBtn;

@property(nonatomic,strong,readwrite) UserUtil *registerUtil;

@end

@implementation RegisterViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        UILabel *titleView = [[UILabel alloc] init];
        titleView.text = @"注册";
        titleView.font = [UIFont systemFontOfSize:18];
        titleView.textColor = [UIColor colorWithRGB:0x286DD6 lpha:1];
        self.navigationItem.titleView = titleView;

        [self.view addSubview:({
            UIImageView *user = [[UIImageView alloc] initWithFrame:CGRectMake(80, 203, 25, 25)];
            [user setImage:[UIImage imageNamed:@"user"]];
            user;
        })];
        [self.view addSubview:({
            self.account = [[UITextField alloc] initWithFrame:CGRectMake(122, 202.5, 213, 34)];
            self.account.textColor = [UIColor lightGrayColor];
            self.account.font = [UIFont systemFontOfSize:15];
            self.account.placeholder = @"账号";
            self.account.borderStyle = UITextBorderStyleRoundedRect;//边框圆角
            self.account.delegate = self;
            self.account;
        })];
        [self.view addSubview:({
            UIImageView *lock = [[UIImageView alloc] initWithFrame:CGRectMake(80, 277, 25, 25)];
            [lock setImage:[UIImage imageNamed:@"lock"]];
            lock;
        })];
        [self.view addSubview:({
            self.password = [[UITextField alloc] initWithFrame:CGRectMake(122, 274.5, 213, 34)];
            self.password.textColor = [UIColor lightGrayColor];
            self.password.font = [UIFont systemFontOfSize:15];
            self.password.placeholder = @"密码";
            self.password.borderStyle = UITextBorderStyleRoundedRect;
            self.password.delegate = self;
            self.password;
        })];
        [self.view addSubview:({
            UIImageView *lock = [[UIImageView alloc] initWithFrame:CGRectMake(80, 347, 25, 25)];
            [lock setImage:[UIImage imageNamed:@"lock"]];
            lock;
        })];
        [self.view addSubview:({
            self.confirmPassword = [[UITextField alloc] initWithFrame:CGRectMake(122, 344.5, 213, 34)];
            self.confirmPassword.textColor = [UIColor lightGrayColor];
            self.confirmPassword.font = [UIFont systemFontOfSize:15];
            self.confirmPassword.placeholder = @"确认密码";
            self.confirmPassword.borderStyle = UITextBorderStyleRoundedRect;
            self.confirmPassword.delegate = self;
            self.confirmPassword;
        })];
        [self.view addSubview:({
            self.registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(74, 462, 272, 45)];
            self.registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            self.registerBtn.backgroundColor = [UIColor colorWithRGB:0x5abce3 lpha:0.9];
            [self.registerBtn setTitle:@"立即注册" forState:UIControlStateNormal];
            self.registerBtn.titleLabel.textColor = [UIColor blackColor];
            self.registerBtn.layer.cornerRadius = 10;
            self.registerBtn.layer.masksToBounds = YES;
            //增加点击事件(一个手势只能赋值给一个view对象,或者更多？)
            UITapGestureRecognizer *toRegisterGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doRegister)];
            [self.registerBtn addGestureRecognizer:toRegisterGesture];
            self.registerBtn;
        })];
        [self.view addSubview:({
            UILabel *toRegister = [[UILabel alloc] initWithFrame:CGRectMake(150, 534, 272, 31)];
            toRegister.font = [UIFont systemFontOfSize:14];
            toRegister.textColor = [UIColor lightGrayColor];
            toRegister.text = @"良好的体验从注册开始";
            toRegister;
        })];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registerUtil = [[UserUtil alloc] init];
}

#pragma mark 进行注册
- (void)doRegister{
    NSString *account = _account.text;
    //1 账户已输入且没有被注册过
    if(![_registerUtil isUserAvailable:account]){
        NSString *password1 = _password.text;
        NSString *password2 = _confirmPassword.text;
        //2 判断两次密码是否相等
        if([_registerUtil isPwdSame:password1 andPwdTwo:password2]){
            //进行注册
            BOOL isAdded = [_registerUtil addUserWithAccount:account AndPwd:password1];
            if(isAdded){
                [self.navigationController popViewControllerAnimated:YES];
                
                NSLog(@"注册成功");
            }else{
                NSLog(@"注册失败");
            }
        }
    }
}

#pragma mark UITextFieldDelegate
//收起键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
