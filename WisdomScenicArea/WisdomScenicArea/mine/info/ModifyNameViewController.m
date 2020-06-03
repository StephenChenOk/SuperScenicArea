//
//  ModifyNameViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/27.
//

#import "ModifyNameViewController.h"
#import "UserUtil.h"

//修改昵称
@interface ModifyNameViewController ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) UITextField *modifyName;

@end

@implementation ModifyNameViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"修改昵称";

        UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] init];
        saveBtn.target = self;
        saveBtn.action = @selector(save);
        saveBtn.title = @"保存";
        self.navigationItem.rightBarButtonItem = saveBtn;

        [self.view addSubview:({
            _modifyName = [[UITextField alloc] initWithFrame:CGRectMake(20, 125, 374, 34)];
            _modifyName.placeholder = @"昵称";
            _modifyName.font = [UIFont systemFontOfSize:17];
            _modifyName.borderStyle = UITextBorderStyleRoundedRect;
            _modifyName.delegate = self;
            _modifyName;
        })];
        [self.view addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 175, 374, 21)];
            label.text = @"一个好名字一种好心情";
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor lightGrayColor];
            label;
            
        })];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"sss");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)save {
    UserUtil *util = [[UserUtil alloc] init];
    BOOL isModifyName = [util modifyName:_modifyName.text];
    if(isModifyName){   //修改成功
        NSLog(@"昵称已修改");
        //更新用户信息
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:_modifyName.text forKey:@"username"];
        [userDefault synchronize];  //立即写入磁盘
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"修改失败，请重试");
    }
    
}

@end
