//
//  ModifyPhoneViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/27.
//

#import "ModifyPhoneViewController.h"
#import "UserUtil.h"

//修改手机号码
@interface ModifyPhoneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *modifyPhone;

@end

@implementation ModifyPhoneViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"修改手机号码";
        UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] init];
        saveBtn.target = self;
        saveBtn.action = @selector(save);
        saveBtn.title = @"保存";
        self.navigationItem.rightBarButtonItem = saveBtn;

        [self.view addSubview:({
            _modifyPhone = [[UITextField alloc] initWithFrame:CGRectMake(20, 125, 374, 34)];
            _modifyPhone.placeholder = @"手机号码";
            _modifyPhone.font = [UIFont systemFontOfSize:17];
            _modifyPhone.borderStyle = UITextBorderStyleRoundedRect;
            _modifyPhone.delegate = self;
            _modifyPhone;
        })];
        [self.view addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 175, 374, 21)];
            label.text = @"留下电话好联系呀";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor lightGrayColor];
            label;
        })];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)save {
    UserUtil *util = [[UserUtil alloc] init];
    BOOL isModifyPhone = [util modifyPhone:_modifyPhone.text];
    if (isModifyPhone) {
        NSLog(@"手机号码已修改");
        //更新用户信息
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_modifyPhone.text forKey:@"phoneNum"];
        [userDefault synchronize];  //立即写入磁盘
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        NSLog(@"修改失败，请重试");
    }
}

@end
