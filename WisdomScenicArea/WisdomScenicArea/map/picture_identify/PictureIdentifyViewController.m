//
//  PictureIdentifyViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/28.
//

#import "PictureIdentifyViewController.h"
#import "UIColor+TransformColor.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDWebImage.h>
#import "ScenicDescribeUtil.h"
#import <MBProgressHUD/MBProgressHUD.h>

//拍照识别服务器url
#define SCENIC_IDENTIFY_SERVER_URL "http://47.102.153.115:8989/infer"

//拍照识别
@interface PictureIdentifyViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong, readwrite) UIImageView *ivPicture;
@property (nonatomic, strong, readwrite) UITextView *tvInfo;

@property (nonatomic, strong, readwrite) NSData *pictureData;

@end

@implementation PictureIdentifyViewController

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
    self.navigationItem.title = @"拍照识别";

    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(135, 115, 145, 21)];
        label.text = @"一处景点 一个故事";
        label;
    })];
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(135, 160, 145, 21)];
        label.text = @"拍照识别 知晓故事";
        label;
    })];
    [self.view addSubview:({
        UIView *box = [[UIView alloc] initWithFrame:CGRectMake(107, 203, 200, 180)];
        box.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];

        [box addSubview:({
            _ivPicture = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 180, 165)];
            _ivPicture.image = [UIImage imageNamed:@"camera_130*110"];

            _ivPicture.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(get_picture)];
            [_ivPicture addGestureRecognizer:tapGesture];

            _ivPicture;
        })];

        box;
    })];
    [self.view addSubview:({
        _tvInfo = [[UITextView alloc] initWithFrame:CGRectMake(20, 420, 374, 443)];
        _tvInfo.text = @"未进行识别";
        _tvInfo.font = [UIFont systemFontOfSize:16];

        //设置内边距
        _tvInfo.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5);

        //设置圆角半径为方形边长一半
        [_tvInfo.layer setCornerRadius:10];
        [_tvInfo.layer setMasksToBounds:YES];

        //设置边框宽度和颜色
        [_tvInfo.layer setBorderWidth:0.5];
        [_tvInfo.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

        _tvInfo;
    })];
}

#pragma mark 点击事件
//获取照片
- (void)get_picture {
    NSLog(@"获取照片");

    [self showSheet];
}

#pragma mark --显示弹窗选择
- (void)showSheet {
    //显示弹出框列表选择
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮相应事件
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
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
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
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
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
        //响应事件
        NSLog(@"取消");
    }];
    [alert addAction:takePhotoAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark UIImagePickerController代理回调
//选择图片成功回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    //NSURL *url =[info objectForKey:UIImagePickerControllerImageURL];    //获取图片地址url，不是真实地址，实用sd_webimage无法加载成功
    //UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];  //获取原图
    UIImage *editImage = [info objectForKey:UIImagePickerControllerEditedImage];    //获取裁剪后的图片

    _ivPicture.image = editImage;
    _ivPicture.userInteractionEnabled = NO;

    //1 显示loading
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.label.text = @"识别中";
    //2 开启子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //将图片写入沙盒文件
        [self savePicture:editImage withPictureName:@"identify.jpg"];
    });

    //退出界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消图片选择调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //退出界面
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --上传图片
- (void)uploadImage {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSData *data = _pictureData;

    [manager POST:@SCENIC_IDENTIFY_SERVER_URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (formData != nil) {
            [formData appendPartWithFileData:data name:@"img" fileName:@"identify.jpg" mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"识别成功----> %@", response);
        //更新界面
        //转回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
                           //隐藏loading
                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                           [self updateView:response];
                       });
    } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
        if (error) {
            NSLog(@"上传图片出错----》%@", error);
            //隐藏loading
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

//保存文件到沙盒
- (void)savePicture:(UIImage *)picture withPictureName:(NSString *)pictureName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoty = [paths objectAtIndex:0];
    //获取最终图片文件存储地址
    NSString *picturePath = [documentsDirectoty stringByAppendingPathComponent:pictureName];
    //将图片数据写入图片文件
    _pictureData = UIImagePNGRepresentation(picture);
    if ([_pictureData writeToFile:picturePath atomically:YES]) {
        NSLog(@"写入图片成功");
        [self uploadImage];
    } else {
        NSLog(@"写入图片失败");
    }
}

#pragma mark --更新景物识别结果view
- (void)updateView:(NSString *)response {
//    NSDictionary *data = [self jsonDictWithString:response];
//    NSLog(@"NSDictionary: %@",data);
//    NSString *name = [data objectForKey:@"name"];
//    NSLog(@"name = %@",name);

    //{"label":0, "name":"象山岩", "possibility":100.00%}
    NSArray *array1 = [response componentsSeparatedByString:@","];
    NSArray *array2 = [array1[1] componentsSeparatedByString:@":"];
    NSArray *array3 = [array2[1] componentsSeparatedByString:@"\""];
    NSString *name = array3[1];
    NSLog(@"name = %@", name);

    if ([name isEqualToString:@"象山岩"]) {
        _tvInfo.text = [ScenicDescribeUtil getElephantHillInfo];
    }
    if ([name isEqualToString:@"普贤塔"]) {
        _tvInfo.text = [ScenicDescribeUtil getTown];
    }
    if ([name isEqualToString:@"timeout"]) {
        _tvInfo.text = @"上传超时...,请重试";
        _ivPicture.image = [UIImage imageNamed:@"camera_130*110"];
        _ivPicture.userInteractionEnabled = YES;
    }
}

@end
