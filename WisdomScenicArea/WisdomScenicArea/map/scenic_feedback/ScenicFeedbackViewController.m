//
//  ScenicFeedbackViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/28.
//

#import "ScenicFeedbackViewController.h"
#import "UIColor+TransformColor.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDWebImage.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define FEEDBACK_SERVER_URL "http://47.102.153.115:8080/isa/feedback"

//景区反馈
@interface ScenicFeedbackViewController ()<UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong, readwrite) UITextField *tfName;
@property (nonatomic, strong, readwrite) UITextField *tfLocation;
@property (nonatomic, strong, readwrite) UIImageView *ivPicture;
@property (nonatomic, strong, readwrite) UITextView *tvContent;
@property (nonatomic, strong, readwrite) UITextField *tfPhoneNum;
@property (nonatomic, strong, readwrite) UIButton *btnSubmit;

@property (nonatomic, strong, readwrite) NSData *pictureData;

@end

@implementation ScenicFeedbackViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark 初始化view
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"景区反馈";

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 113, 70, 21)];
        label.text = @"地点名称";
        label;
    })];
    [self.view addSubview:({
        _tfName = [[UITextField alloc] initWithFrame:CGRectMake(98, 108, 296, 34)];
        _tfName.placeholder = @"输入这个地点的名称";
        _tfName.borderStyle = UITextBorderStyleNone;
        _tfName;
    })];
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 152, 394, 1)];
        line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        line;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 171, 70, 21)];
        label.text = @"所在位置";
        label;
    })];
    [self.view addSubview:({
        _tfLocation = [[UITextField alloc] initWithFrame:CGRectMake(98, 166, 296, 34)];
        _tfLocation.placeholder = @"输入这个地点的详细位置";
        _tfLocation;
    })];
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 209, 394, 8)];
        line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        line;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 228, 70, 21)];
        label.text = @"添加图片";
        label;
    })];
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 264, 394, 1)];
        line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        line;
    })];

    [self.view addSubview:({
        _ivPicture = [[UIImageView alloc] initWithFrame:CGRectMake(20, 275, 60, 55)];
        _ivPicture.image = [UIImage imageNamed:@"camera"];

        _ivPicture.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(get_picture)];
        [_ivPicture addGestureRecognizer:tapGesture];

        _ivPicture;
    })];
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 337, 374, 50)];
        label.text = @"请对准要反馈的地点进行拍照，上传真实的照片能提高反馈的成功率";
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:15];
        label;
    })];
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 394, 394, 8)];
        line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        line;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 415, 70, 21)];
        label.text = @"问题描述";
        label;
    })];
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 450, 394, 1)];
        line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        line;
    })];

    [self.view addSubview:({
        _tvContent = [[UITextView alloc] initWithFrame:CGRectMake(20, 466, 374, 100)];
        _tvContent.text = @"请输入您要反馈的内容";
        _tvContent.textColor = [UIColor grayColor];
        _tvContent.delegate = self;
        _tvContent.font = [UIFont systemFontOfSize:16];

        //设置内边距
        _tvContent.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);

        //设置圆角半径为方形边长一半
        [_tvContent.layer setCornerRadius:10];
        [_tvContent.layer setMasksToBounds:YES];

        //设置边框宽度和颜色
        [_tvContent.layer setBorderWidth:0.5];
        [_tvContent.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

        _tvContent;
    })];
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(285, 572, 135, 17)];
        label.text = @"输入5-300个字符";
        label.font = [UIFont systemFontOfSize:13];
        label;
    })];
    [self.view addSubview:({
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 600, 394, 8)];
        line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
        line;
    })];

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 635, 70, 21)];
        label.text = @"联系方式";
        label;
    })];
    [self.view addSubview:({
        _tfPhoneNum = [[UITextField alloc] initWithFrame:CGRectMake(98, 630, 296, 34)];
        _tfPhoneNum.placeholder = @"请输入您的联系方式";
        _tfPhoneNum;
    })];

    [self.view addSubview:({
        _btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(57, 700, 300, 45)];
        _btnSubmit.backgroundColor = [UIColor colorWithRGB:0x5abce3 lpha:0.9];
        [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
        _btnSubmit.layer.cornerRadius = 10;
        _btnSubmit.layer.masksToBounds = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(submit)];
        [_btnSubmit addGestureRecognizer:tapGesture];
        _btnSubmit;
    })];
}

#pragma mark 点击事件
//获取照片
- (void)get_picture {
    NSLog(@"获取照片");
    //1 相册中获取
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        //实例化
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        //设置资源来源(相册、相机、图库之一)
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置代理
        imagePickerVC.delegate = self;
        //是否允许编辑
        imagePickerVC.allowsEditing = YES;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
    } else {
        NSLog(@"相册资源不可用");
    }
}

//提交反馈
- (void)submit {
    //判断是否填写完整
    NSString *name = _tfName.text;
    NSString *location = _tfLocation.text;
    NSString *content = _tvContent.text;
    NSString *phone = _tfPhoneNum.text;

    if ([name isEqualToString:@""] || [location isEqualToString:@""] || [content isEqualToString:@""] || [phone isEqualToString:@""]) {
        NSLog(@"请填写完成再提交");
    } else {
        NSLog(@"提交反馈");
        //1 显示loading
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.label.text = @"提交反馈中";
        //2 开启子线程
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //上传到服务器
            [self uploadServerWithName:name location:location content:content phone:phone];
        });
    }
}

- (void)savePicture:(UIImage *)picture withPictureName:(NSString *)pictureName {
    //保存文件到沙盒
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoty = [paths objectAtIndex:0];
    //获取最终图片文件存储地址
    NSString *picturePath = [documentsDirectoty stringByAppendingPathComponent:pictureName];
    //将图片数据写入图片文件
    _pictureData = UIImagePNGRepresentation(picture);
    if ([_pictureData writeToFile:picturePath atomically:YES]) {
        NSLog(@"写入图片成功");
    } else {
        NSLog(@"写入图片失败");
    }
}

- (void)uploadServerWithName:(NSString *)name location:(NSString *)location content:(NSString *)content phone:(NSString *)phone {
    NSData *data = _pictureData;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    //参数
    NSDictionary *parameters = @{ @"requestType": @"景区反馈", @"place": name, @"detailed_place": location, @"content": content, @"contact_info": phone };

    [manager POST:@FEEDBACK_SERVER_URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (formData != nil) {
            [formData appendPartWithFileData:data name:@"image" fileName:@"feedback.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"上传成功----> %@", response);
        //转回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
                           //隐藏loading
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self.navigationController popViewControllerAnimated:YES];
                       });
    } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
        if (error) {
            NSLog(@"上传出错----》%@", error);
            //隐藏loading
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

#pragma mark UIImagePickerController代理回调
//选择图片成功回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    //NSURL *pictureURL = [info objectForKey:UIImagePickerControllerImageURL];
    //UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];  //获取原图
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];    //获取裁剪后的图片

    _ivPicture.image = editImage;

    [self savePicture:editImage withPictureName:@"feedback.jpg"];

    //退出界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消图片选择调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //退出界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITextViewDelegate
//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length < 1) {
        textView.text = @"请输入您要反馈的内容";
        textView.textColor = [UIColor grayColor];
    }
}

//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请输入您要反馈的内容"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}

@end
