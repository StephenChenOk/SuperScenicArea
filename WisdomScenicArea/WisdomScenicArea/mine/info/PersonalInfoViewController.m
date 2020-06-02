//
//  PersonalInfoViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/27.
//

//个人信息
#import "PersonalInfoViewController.h"
#import "UIColor+TransformColor.h"
#import "QFTouchView.h"
#import "ModifyNameViewController.h"
#import "ModifyPhoneViewController.h"
#import "UserUtil.h"
#import <SDWebImage/SDWebImage.h>

#define topbarHeight 88

@interface PersonalInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong, readwrite) QFTouchView *headBox;
@property (nonatomic, strong, readwrite) QFTouchView *nameBox;
@property (nonatomic, strong, readwrite) QFTouchView *accountBox;
@property (nonatomic, strong, readwrite) QFTouchView *phoneBox;

@property (nonatomic, strong, readwrite) UIImageView *headIcon;
@property (nonatomic, strong, readwrite) UILabel *nameText;
@property (nonatomic, strong, readwrite) UILabel *accountText;
@property (nonatomic, strong, readwrite) UILabel *phoneText;

@end

@implementation PersonalInfoViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"个人信息";
//        titleView.font = [UIFont systemFontOfSize:18];
//        titleView.textColor = [UIColor colorWithRGB:0x286DD6 lpha:1];
//        self.navigationItem.titleView = titleView;

        [self initView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [self setUserInfo];
}

#pragma mark initView
- (void)initView {
    //1 头像box
    [self.view addSubview:({
        _headBox = [[QFTouchView alloc] initWithFrame:CGRectMake(0, 88, 414, 95)];

        //为head box添加子元素
        [_headBox addSubview:({
            UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 37, 39, 23)];
            headLabel.text = @"头像";
            headLabel.font = [UIFont systemFontOfSize:19];
            headLabel;
        })];
        [_headBox addSubview:({
            _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(298,  14, 70, 70)];
            _headIcon.image = [UIImage imageNamed:@"headIcon"];
            //设置圆角半径为方形边长一半
            [_headIcon.layer setCornerRadius:5];
            [_headIcon.layer setMasksToBounds:YES];
            _headIcon;
        })];
        [_headBox addSubview:({
            UIImageView *gotoHead = [[UIImageView alloc] initWithFrame:CGRectMake(385,  41, 15, 15)];
            gotoHead.image = [UIImage imageNamed:@"goto_20"];
            gotoHead;
        })];

        UITapGestureRecognizer *headGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoHeadIconPage)];
        headGesture.cancelsTouchesInView = NO;
        [_headBox addGestureRecognizer:headGesture];
        _headBox;
    })];
    //分割线
    [self.view addSubview:({
        UIView *divideHead = [[UIView alloc]initWithFrame:CGRectMake(20, 191, 394, 1)];
        divideHead.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        divideHead;
    })];

    //2 昵称box
    [self.view addSubview:({
        _nameBox = [[QFTouchView alloc] initWithFrame:CGRectMake(0,  200, 414, 61)];

        //为name box添加子元素
        [_nameBox addSubview:({
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 19, 39, 23)];
            nameLabel.text = @"昵称";
            nameLabel.font = [UIFont systemFontOfSize:19];
            nameLabel;
        })];
        [_nameBox addSubview:({
            _nameText = [[UILabel alloc] initWithFrame:CGRectMake(258, 19, 108, 21)];
            _nameText.font = [UIFont systemFontOfSize:17];
            _nameText.textColor = [UIColor darkGrayColor];
            _nameText.textAlignment = NSTextAlignmentRight;
            _nameText;
        })];
        [_nameBox addSubview:({
            UIImageView *gotoName = [[UIImageView alloc] initWithFrame:CGRectMake(385, 23, 15, 15)];
            gotoName.image = [UIImage imageNamed:@"goto_20"];
            gotoName;
        })];

        //设置点击事件
        UITapGestureRecognizer *nameGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoNamePage)];
        nameGesture.cancelsTouchesInView = NO;
        [_nameBox addGestureRecognizer:nameGesture];

        _nameBox;
    })];
    //分割线
    [self.view addSubview:({
        UIView *divideName = [[UIView alloc]initWithFrame:CGRectMake(20, 269, 394, 1)];
        divideName.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        divideName;
    })];

    //3 账号box
    [self.view addSubview:({
        _accountBox = [[QFTouchView alloc] initWithFrame:CGRectMake(0, 278, 414, 61)];

        //为account box添加子view
        [_accountBox addSubview:({
            UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(31, 19, 39, 23)];
            accountLabel.text = @"账号";
            accountLabel.font = [UIFont systemFontOfSize:19];
            accountLabel;
        })];
        [_accountBox addSubview:({
            _accountText = [[UILabel alloc] initWithFrame:CGRectMake(258, 19, 108, 21)];
            _accountText.font = [UIFont systemFontOfSize:17];
            _accountText.textColor = [UIColor darkGrayColor];
            _accountText.textAlignment = NSTextAlignmentRight;
            _accountText;
        })];
        [_accountBox addSubview:({
            UIImageView *gotoAccount = [[UIImageView alloc] initWithFrame:CGRectMake(385,  23, 15, 15)];
            gotoAccount.image = [UIImage imageNamed:@"goto_20"];
            gotoAccount;
        })];

        //设置点击事件
        UITapGestureRecognizer *accountGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoAccountPage)];
        [_accountBox addGestureRecognizer:accountGesture];
        accountGesture.cancelsTouchesInView = NO;
        _accountBox;
    })];
    //分割线
    [self.view addSubview:({
        UIView *divideHead = [[UIView alloc]initWithFrame:CGRectMake(20, 347, 394, 1)];
        divideHead.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        divideHead;
    })];

    //4 手机号码box
    [self.view addSubview:({
        _phoneBox = [[QFTouchView alloc] initWithFrame:CGRectMake(0, 356, 414, 61)];

        //为phone box添加子view
        [_phoneBox addSubview:({
            UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(31,  19, 78, 23)];
            phoneLabel.text = @"手机号码";
            phoneLabel.font = [UIFont systemFontOfSize:19];
            phoneLabel;
        })];
        [_phoneBox addSubview:({
            _phoneText = [[UILabel alloc] initWithFrame:CGRectMake(258, 19, 108, 21)];
            _phoneText.font = [UIFont systemFontOfSize:17];
            _phoneText.textColor = [UIColor darkGrayColor];
            _phoneText.textAlignment = NSTextAlignmentRight;
            _phoneText;
        })];
        [_phoneBox addSubview:({
            UIImageView *gotoPhone = [[UIImageView alloc] initWithFrame:CGRectMake(385,  23, 15, 15)];
            gotoPhone.image = [UIImage imageNamed:@"goto_20"];
            gotoPhone;
        })];

        //设置点击事件
        UITapGestureRecognizer *phoneGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoPhonePage)];
        [_phoneBox addGestureRecognizer:phoneGesture];
        phoneGesture.cancelsTouchesInView = NO;
        _phoneBox;
    })];

    //5 退出账号
    [self.view addSubview:({
        UILabel *logout = [[UILabel alloc] initWithFrame:CGRectMake(0, 812, 414, 50)];
        logout.text = @"退出当前账号";
        logout.font = [UIFont systemFontOfSize:20];
        logout.textColor = [UIColor redColor];
        logout.textAlignment = NSTextAlignmentCenter;

        //设置点击事件
        logout.userInteractionEnabled = YES;
        UITapGestureRecognizer *logoutGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logout)];
        [logout addGestureRecognizer:logoutGesture];

        logout;
    })];
}

#pragma mark 设置用户信息
- (void)setUserInfo {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"username"];
    NSString *account = [userDefaults objectForKey:@"account"];
    NSString *phoneNum = [userDefaults objectForKey:@"phoneNum"];
//    NSString *headUrl = [userDefaults objectForKey:@"headURL"];
    
    _nameText.text = name;
    _accountText.text = account;
    _phoneText.text = phoneNum;
//    [_headIcon sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:[UIImage imageNamed:@"headIcon"]];
}

#pragma mark touch事件回调
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"手指离开屏幕");
}

#pragma mark 点击事件
//点击头像
- (void)gotoHeadIconPage {
//    NSLog(@"点击头像");
//    //1 相册中获取
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
//        //实例化
//        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
//        //设置资源来源(相册、相机、图库之一)
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        //设置代理
//        imagePickerVC.delegate = self;
//        //是否允许编辑
//        imagePickerVC.allowsEditing = YES;
//        [self presentViewController:imagePickerVC animated:YES completion:nil];
//    }else{
//        NSLog(@"相册资源不可用");
//    }
    
    //2 相机中获取(模拟器无摄像头可用？)
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        //实例化
//        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
//        //设置资源来源(相册、相机、图库之一)
//        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //设置代理
//        imagePickerVC.delegate = self;
//        //相机获取媒体的类型（相机、录制视频）
//        imagePickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        [self presentViewController:imagePickerVC animated:YES completion:nil];
//    }else{
//        NSLog(@"无摄像头可用");
//    }
        
}

//点击昵称
- (void)gotoNamePage {
    ModifyNameViewController *modifyNamePage = [[ModifyNameViewController alloc] init];
    [self.navigationController pushViewController:modifyNamePage animated:YES];
}

//点击账号
- (void)gotoAccountPage {
    NSLog(@"点击账号");
}

//点击手机号码
- (void)gotoPhonePage {
    ModifyPhoneViewController *modifyPhonePage = [[ModifyPhoneViewController alloc] init];
    [self.navigationController pushViewController:modifyPhonePage animated:YES];
}

//退出当前账号
- (void)logout {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"account"];
    [userDefaults removeObjectForKey:@"username"];
    [userDefaults removeObjectForKey:@"phoneNum"];
//    [userDefaults removeObjectForKey:@"headURL"];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"已退出当前账号");
}

#pragma mark UIImagePickerController代理回调
//选择图片成功回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSURL *url =[info objectForKey:UIImagePickerControllerImageURL];    //获取图片地址url，不是真实地址，实用sd_webimage无法加载成功
    //UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];  //获取原图
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];    //获取裁剪后的图片
    NSString *imageName = url.path.lastPathComponent;
    //将图片保存到本地沙盒中
    //1 找到本地沙盒中的Document目录（存放一些较大的文件）
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //2 在目录下创建一个图片，返回路径
    NSString *imagePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
    //3 写入图片资源
    if([UIImagePNGRepresentation(editImage) writeToFile:imagePath atomically:YES]){
        NSLog(@"保存头像成功");
    }else{
        NSLog(@"保存头像失败");
    }
    
    UserUtil *util = [[UserUtil alloc] init];
    BOOL isModified = [util modifyHeadIcon:imagePath];
    if(isModified){
        NSLog(@"修改头像成功");
        //更换头像
        _headIcon.image = editImage;
    }else{
        NSLog(@"修改头像出错");
    }
    
    //退出界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消图片选择调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //退出界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
