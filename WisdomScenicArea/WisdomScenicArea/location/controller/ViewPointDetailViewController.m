//
//  ViewPointDetailViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import "ViewPointDetailViewController.h"
#import "ViewPointItem.h"
#import "UIColor+TransformColor.h"
#import "QFLabelView.h"
#import <AFNetworking/AFNetworking.h>
#import "ScreenUtil.h"

#define BIG_DATA_SERVER_URL_CQ "http://47.102.153.115:8877/pre"
#define BIG_DATA_SERVER_URL_SH "http://47.102.153.115:8877/spre"

@interface ViewPointDetailViewController ()

@property (nonatomic, strong, readwrite) UIImageView *ivImage;
@property (nonatomic, strong, readwrite) QFLabelView *lbInfo;
@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

@property (nonatomic, strong, readwrite) UILabel *lbToday;
@property (nonatomic, strong, readwrite) UILabel *lbTomorrow;

@end

@implementation ViewPointDetailViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getDataFromServer];
}

//初始化景点详情信息
- (void)initDetailData:(ViewPointItem *)item {
    self.navigationItem.title = item.name;
    self.navigationItem.leftBarButtonItem.width = 10;
    self.ivImage.image = [UIImage imageNamed:item.imgUrl];

    //根据label中内容的大小自适应label大小
    self.lbInfo.text = item.detailInfo;
    CGSize labelSize = [item.detailInfo boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 3) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  | NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:UI(17)] } context:nil].size;
    self.lbInfo.frame = CGRectMake(UI(3), UI(551), ceil(labelSize.width-3), ceil(labelSize.height + 100) );

    
    //设置scrollView内容的大小
    _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, _lbInfo.frame.origin.y + _lbInfo.bounds.size.height);
}

- (void)initView {
    [self.view addSubview:({
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

        [_scrollView addSubview:({
            _ivImage = [[UIImageView alloc] initWithFrame:UIRect(0, 0, 414, 250)];
            _ivImage;
        })];
        [_scrollView addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:UIRect(0, 250, 414, 10)];
            line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
            line;
        })];
        [_scrollView addSubview:({
            _lbToday = [[UILabel alloc] initWithFrame:UIRect(70, 275, 70, 21)];
            _lbToday.text = @"今日天气";
            _lbToday.font = [UIFont systemFontOfSize:UI(17)];
            _lbToday.textColor = [UIColor colorWithRGB:0x5abce3 lpha:1];
            
            _lbToday.userInteractionEnabled =YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(today_weather)];
            [_lbToday addGestureRecognizer:tap];
            
            _lbToday;
        })];
        [_scrollView addSubview:({
            _lbTomorrow = [[UILabel alloc] initWithFrame:UIRect(278, 275, 70, 21)];
            _lbTomorrow.text = @"明日天气";
            _lbTomorrow.font = [UIFont systemFontOfSize:UI(17)];
            _lbTomorrow.userInteractionEnabled =YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tomorrow_weather)];
            [_lbTomorrow addGestureRecognizer:tap];
            
            _lbTomorrow;
        })];
        [_scrollView addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:UIRect(0, 310, 414, 1)];
            line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
            line;
        })];
        [_scrollView addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:UIRect(207, 266, 1, 40)];
            line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
            line;
        })];
        [_scrollView addSubview:({
            UIImageView *image = [[UIImageView alloc] initWithFrame:UIRect(83, 324, 45, 45)];
            image.image = [UIImage imageNamed:@"yin"];
            image;
        })];
        [_scrollView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:UIRect(88, 375, 35, 21)];
            label.font = [UIFont systemFontOfSize:UI(17)];
            label.text = @"多云";
            label;
        })];
        [_scrollView addSubview:({
            UIImageView *image = [[UIImageView alloc] initWithFrame:UIRect(291, 324, 45, 45)];
            image.image = [UIImage imageNamed:@"temperature"];
            image;
        })];
        [_scrollView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:UIRect(288, 375, 51, 21)];
            label.text = @"22.1℃";
            label.font = [UIFont systemFontOfSize:UI(17)];
            label;
        })];
        [_scrollView addSubview:({
            UIImageView *image = [[UIImageView alloc] initWithFrame:UIRect(83, 415, 45, 45)];
            image.image = [UIImage imageNamed:@"humidity"];
            image;
        })];
        [_scrollView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:UIRect(79, 465, 52, 21)];
            label.text = @"72.3 %";
            label.font = [UIFont systemFontOfSize:UI(17)];
            label;
        })];
        [_scrollView addSubview:({
            UIImageView *image = [[UIImageView alloc] initWithFrame:UIRect(291, 415, 40, 40)];
            image.image = [UIImage imageNamed:@"visibility"];
            image;
        })];
        [_scrollView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:UIRect(266, 465, 95, 21)];
            label.text = @"12860.155m";
            label.font = [UIFont systemFontOfSize:UI(17)];
            label;
        })];
        [_scrollView addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:UIRect(0, 503, 414, 10)];
            line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
            line;
        })];
        [_scrollView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:UIRect(157, 521, 100, 21)];
            label.text = @"景点简介";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:UI(17)];
            label;
        })];
        [_scrollView addSubview:({
            _lbInfo = [[QFLabelView alloc] init];
            _lbInfo.numberOfLines = 0;
            _lbInfo.font = [UIFont systemFontOfSize:UI(17)];
            _lbInfo.enabled = NO;
            _lbInfo;
        })];

        _scrollView;
    })];
}

#pragma mark --获取大数据
- (void)getDataFromServer {
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//    NSURL *url = [NSURL URLWithString:@BIG_DATA_SERVER_URL_CQ];
//    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
//
//    NSURLSessionTask *dataTask = [manager dataTaskWithRequest:requset completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){
//        if(error){
//            NSLog(@"获取天气数据失败,error:%@",error);
//        }else{
//            NSString *data = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"%@",data);
//        }
//    }];
//
//    [dataTask resume];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:@BIG_DATA_SERVER_URL_CQ parameters:nil success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nullable responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"获取天气数据成功----> %@", response);
    } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
        if (error) {
            NSLog(@"获取天气数据失败");
        }
    }];
}

#pragma mark --点击事件
- (void)today_weather{
    _lbTomorrow.textColor = [UIColor blackColor];
    _lbToday.textColor = [UIColor colorWithRGB:0x5abce3 lpha:1];
}

- (void)tomorrow_weather{
    _lbToday.textColor = [UIColor blackColor];
    _lbTomorrow.textColor = [UIColor colorWithRGB:0x5abce3 lpha:1];
}

@end
