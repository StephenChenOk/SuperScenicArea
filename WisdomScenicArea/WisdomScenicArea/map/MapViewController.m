//
//  MapViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "PictureIdentifyViewController.h"
#import "SceneryPushViewController.h"
#import "ScenicFeedbackViewController.h"
#import "RoadPlanningUtil.h"
#import <SocketRocket/SocketRocket.h>
#import "AStarUtils.h"
#import <CoreBluetooth/CoreBluetooth.h>

//websocket服务器url
#define RATE_FLOW_URL "ws://47.102.153.115:8080/isa/websocket"

@interface MapViewController ()<UITextFieldDelegate, MAMapViewDelegate, SRWebSocketDelegate>

@property (nonatomic, strong, readwrite) MAMapView *mapView;

@property (nonatomic, readwrite) double latitude;     //纬度
@property (nonatomic, readwrite) double longitude;    //经度

//路线规划用到的view
@property (nonatomic, strong, readwrite) UIView *road_planning_box;
@property (nonatomic, strong, readwrite) UITextField *inputStart;
@property (nonatomic, strong, readwrite) UITextField *inputEnd;

//websocket
@property (nonatomic, strong) SRWebSocket *socket;

@property (nonatomic, copy, readwrite) NSString *message;    //用来记录服务器返回数据前后是否相同

@property (nonatomic, readwrite) NSMutableArray *locations;  //地点
@property (nonatomic, readwrite) NSMutableArray *numbers;    //人数

//marker
@property (nonatomic, readwrite) MAPointAnnotation *point1;  //普贤塔
@property (nonatomic, readwrite) MAPointAnnotation *point2;  //象眼岩
@property (nonatomic, readwrite) MAPointAnnotation *point3;  //桂林抗战遗址

//circle
@property (nonatomic, readwrite) MACircle *circle1;  //普贤塔
@property (nonatomic, readwrite) MACircle *circle2;  //象眼岩
@property (nonatomic, readwrite) MACircle *circle3;  //桂林抗战遗址

//标志是否是第一次进入地图，收到服务器消息
@property (nonatomic, readwrite) BOOL isFirst;

@end

@implementation MapViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

#pragma mark --生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if (_socket == nil) {
        [self initWebSocket];
    } else {
        [_socket open];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [_socket close];
    _socket = nil;
}

#pragma mark --初始化view
//初始化界面
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"地图";

    [self initMapView];

    //初始化右侧功能模块界面
    //box
    [self.view addSubview:({
        UIView *box = [[UIView alloc] initWithFrame:CGRectMake(344, 130, 50, 224)];
        box.backgroundColor = [UIColor whiteColor];
        box.layer.cornerRadius = 5;
        box.layer.masksToBounds = YES;
        //拍照识别
        [box addSubview:({
            UIImageView *camera = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 40, 40)];
            camera.image = [UIImage imageNamed:@"camera"];
            camera.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picture_recognition)];
            [camera addGestureRecognizer:tapGesture];
            camera;
        })];
        [box addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 53, 50, 17)];
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"拍照识别";
            label.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(picture_recognition)];
            [label addGestureRecognizer:tapGesture];
            label;
        })];
        [box addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(4, 74, 42, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            line;
        })];

        //路线规划
        [box addSubview:({
            UIImageView *road = [[UIImageView alloc] initWithFrame:CGRectMake(5, 85, 40, 40)];
            road.image = [UIImage imageNamed:@"road"];
            road.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(road_planning)];
            [road addGestureRecognizer:tapGesture];
            road;
        })];
        [box addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 128, 50, 17)];
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"路线规划";
            label.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(road_planning)];
            [label addGestureRecognizer:tapGesture];
            label;
        })];
        [box addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(4, 148, 42, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            line;
        })];

        //景区反馈
        [box addSubview:({
            UIImageView *feedback = [[UIImageView alloc] initWithFrame:CGRectMake(5, 158, 40, 40)];
            feedback.image = [UIImage imageNamed:@"feedback"];
            feedback.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scenic_feedback)];
            [feedback addGestureRecognizer:tapGesture];
            feedback;
        })];
        [box addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 201, 50, 17)];
            label.font = [UIFont systemFontOfSize:10];
            label.textColor = [UIColor darkGrayColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"景区反馈";
            label.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scenic_feedback)];
            [label addGestureRecognizer:tapGesture];
            label;
        })];

        box;
    })];
    //景物推送box
    [self.view addSubview:({
        UIView *box = [[UIView alloc] initWithFrame:CGRectMake(344, 380, 50, 70)];
        box.backgroundColor = [UIColor whiteColor];
        box.layer.cornerRadius = 5;
        box.layer.masksToBounds = YES;

        [box addSubview:({
            UIImageView *push = [[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 40, 40)];
            push.image = [UIImage imageNamed:@"senic_push"];
            push.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scenery_push)];
            [push addGestureRecognizer:tapGesture];
            push;
        })];

        [box addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 50, 17)];
            label.font = [UIFont systemFontOfSize:10];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"景物推送";
            label.textColor = [UIColor darkGrayColor];
            label.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scenery_push)];
            [label addGestureRecognizer:tapGesture];
            label;
        })];

        box;
    })];

    //放大缩小box
    [self.view addSubview:({
        UIView *box = [[UIView alloc] initWithFrame:CGRectMake(354, 778, 40, 84)];
        box.backgroundColor = [UIColor whiteColor];

        [box addSubview:({
            UIImageView *zoom = [[UIImageView alloc] initWithFrame:CGRectMake(6, 8, 25, 25)];
            zoom.image = [UIImage imageNamed:@"zoom"];
            zoom.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomMap)];
            [zoom addGestureRecognizer:tapGesture];
            zoom;
        })];

        [box addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(6, 43, 25, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            line;
        })];

        [box addSubview:({
            UIImageView *reduce = [[UIImageView alloc] initWithFrame:CGRectMake(4, 48, 30, 30)];
            reduce.image = [UIImage imageNamed:@"reduce"];
            reduce.userInteractionEnabled = true;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reduceMap)];
            [reduce addGestureRecognizer:tapGesture];
            reduce;
        })];

        box;
    })];
}

//显示路线规划view
- (void)showRoadPlanningView {
    if (self.road_planning_box) {
        NSLog(@"showRoadPlanningView");
        [self.view addSubview:self.road_planning_box];
        return;
    }
    self.road_planning_box = [[UIView alloc] initWithFrame:CGRectMake(10, 95, 300, 96)];
    self.road_planning_box.backgroundColor = [UIColor whiteColor];
    [self.road_planning_box addSubview:({
        UIView *red = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 10, 10)];
        red.backgroundColor = [UIColor redColor];
        red;
    })];
    [self.road_planning_box addSubview:({
        _inputStart = [[UITextField alloc] initWithFrame:CGRectMake(25, 8, 215, 34)];
        _inputStart.placeholder = @"输入起点";
        _inputStart.borderStyle = UITextBorderStyleRoundedRect;
        _inputStart.delegate = self;
        _inputStart;
    })];
    [self.road_planning_box addSubview:({
        UIView *blue = [[UIView alloc] initWithFrame:CGRectMake(10, 66, 10, 10)];
        blue.backgroundColor = [UIColor blueColor];
        blue;
    })];
    [self.road_planning_box addSubview:({
        _inputEnd = [[UITextField alloc] initWithFrame:CGRectMake(25, 54, 215, 34)];
        _inputEnd.borderStyle = UITextBorderStyleRoundedRect;
        _inputEnd.placeholder = @"输入终点";
        _inputEnd.delegate = self;
        _inputEnd;
    })];
    [self.road_planning_box addSubview:({
        UIImageView *go = [[UIImageView alloc] initWithFrame:CGRectMake(253, 22, 34, 34)];
        go.image = [UIImage imageNamed:@"go_40"];
        go.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(start_road_planning)];
        [go addGestureRecognizer:tapGesture];
        go;
    })];
    [self.road_planning_box addSubview:({
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(253, 56, 34, 22)];
        lable.text = @"Go";
        lable.textAlignment = NSTextAlignmentCenter;
        lable;
    })];
    [self.view addSubview:self.road_planning_box];
}

#pragma mark --绘制地图map
//初始化mapView
- (void)initMapView {
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    //将地图添加到view
    [self.view addSubview:self.mapView];
    _mapView.delegate = self;
}

//绘制marker
- (void)drawMarker {
    if (_point1) {
        [_mapView removeAnnotation:_point1];
    }
    if (_point2) {
        [_mapView removeAnnotation:_point2];
    }
    if (_point3) {
        [_mapView removeAnnotation:_point3];
    }

    //普贤塔
    MAPointAnnotation *point1 = [[MAPointAnnotation alloc] init];
    point1.coordinate = CLLocationCoordinate2DMake(25.267242, 110.296046);
    point1.title = @"普贤塔";
    point1.subtitle = [NSString stringWithFormat:@"人流量：%@", _numbers[0]];
    //象眼岩
    MAPointAnnotation *point2 = [[MAPointAnnotation alloc] init];
    point2.coordinate = CLLocationCoordinate2DMake(25.267088, 110.296427);
    point2.title = @"象眼岩";
    point2.subtitle = [NSString stringWithFormat:@"人流量：%@", _numbers[1]];
    //桂林抗战遗址
    MAPointAnnotation *point3 = [[MAPointAnnotation alloc] init];
    point3.coordinate = CLLocationCoordinate2DMake(25.266798, 110.295988);
    point3.title = @"桂林抗战遗址";
    point3.subtitle = [NSString stringWithFormat:@"人流量：%@", _numbers[2]];

    NSArray *points = [NSArray arrayWithObjects:point1, point2, point3, nil];
    [_mapView addAnnotations:points];

    //保存上一个marker
    _point1 = point1;
    _point2 = point2;
    _point3 = point3;
}

//绘制人流量热力图（圆形）
- (void)drawCircle {
    if (_circle1) {
        [_mapView removeOverlay:_circle1];
    }
    if (_circle2) {
        [_mapView removeOverlay:_circle2];
    }
    if (_circle3) {
        [_mapView removeOverlay:_circle3];
    }

    MACircle *circle1 = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(25.267242, 110.296046) radius:[_numbers[0] doubleValue]];
    MACircle *circle2 = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(25.267088, 110.296427) radius:[_numbers[1] doubleValue]];
    MACircle *circle3 = [MACircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(25.266798, 110.295988) radius:[_numbers[2] doubleValue]];

    [_mapView addOverlay:circle1];
    [_mapView addOverlay:circle2];
    [_mapView addOverlay:circle3];

    //保存上一个marker
    _circle1 = circle1;
    _circle2 = circle2;
    _circle3 = circle3;
}

//绘制路线
- (void)drawLineWithStart:(NSString *)start andEnd:(NSString *)end {
    RoadPlanningUtil *roadUtil = [[RoadPlanningUtil alloc] init];
    CLLocationCoordinate2D *points;
    AStarUtils *aStarUtil = [[AStarUtils alloc] init];
    int numbers[3] = { [_numbers[0] intValue], [_numbers[1] intValue], [_numbers[2] intValue] };
    for (int i = 0; i < _numbers.count; i++) {
    }
    NSString *str = [aStarUtil A_Star:numbers start:start end:end];
    //醉乡-->普贤塔
    if ([str isEqualToString:@"zxToTown_road1"]) {
        points = [roadUtil zxToTown_road1];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:11];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zxToTown_road2"]) {
        points = [roadUtil zxToTown_road2];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:15];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zxToTown_road3"]) {
        points = [roadUtil zxToTown_road3];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:11];
        [_mapView addOverlay:polyLine];
    }
    //醉乡-->象眼岩
    if ([str isEqualToString:@"zxToRock_road1"]) {
        points = [roadUtil zxToRock_road1];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:13];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zxToRock_road2"]) {
        points = [roadUtil zxToRock_road2];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:10];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zxToRock_road3"]) {
        points = [roadUtil zxToRock_road3];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:11];
        [_mapView addOverlay:polyLine];
    }
    //醉乡-->桂林抗战遗址
    if ([str isEqualToString:@"zxToRuins_road"]) {
        points = [roadUtil zxToRuins_road];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:8];
        [_mapView addOverlay:polyLine];
    }
    //云峰寺-->普贤塔
    if ([str isEqualToString:@"yfsToTown_road1"]) {
        points = [roadUtil yfsToTown_road1];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:9];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"yfsToTown_road2"]) {
        points = [roadUtil yfsToTown_road2];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:14];
        [_mapView addOverlay:polyLine];
    }
    //云峰寺-->象眼岩
    if ([str isEqualToString:@"yfsToRock_road1"]) {
        points = [roadUtil yfsToRock_road1];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:11];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"yfsToRock_road2"]) {
        points = [roadUtil yfsToRock_road2];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:14];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"yfsToRock_road3"]) {
        points = [roadUtil yfsToRock_road3];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:14];
        [_mapView addOverlay:polyLine];
    }
    //云峰寺-->桂林抗战遗址
    if ([str isEqualToString:@"yfsToRuins_road"]) {
        points = [roadUtil yfsToRuins_road];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:11];
        [_mapView addOverlay:polyLine];
    }
    //象山钟韵-->普贤塔
    if ([str isEqualToString:@"zyToTown_road"]) {
        points = [roadUtil zyToTown_road];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:13];
        [_mapView addOverlay:polyLine];
    }
    //象山钟韵-->象眼岩
    if ([str isEqualToString:@"zyToRock_road1"]) {
        points = [roadUtil zyToRock_road1];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:15];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zyToRock_road2"]) {
        points = [roadUtil zyToRock_road2];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:21];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zyToRock_road3"]) {
        points = [roadUtil zyToRock_road3];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:21];
        [_mapView addOverlay:polyLine];
    }
    //象山钟韵-->桂林抗战遗址
    if ([str isEqualToString:@"zyToRuins_road1"]) {
        points = [roadUtil zyToRuins_road1];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:17];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@"zyToRuins_road2"]) {
        points = [roadUtil zyToRuins_road2];
        MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:points count:18];
        [_mapView addOverlay:polyLine];
    }
    if ([str isEqualToString:@""]) {
        NSLog(@"输入错误");
    }
}

#pragma mark 初始化websocket
- (void)initWebSocket {
    //初始化地点、人数数组
    _locations = [[NSMutableArray alloc] init];
    _numbers = [[NSMutableArray alloc] init];

    NSURL *url = [NSURL URLWithString:@RATE_FLOW_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //初始化websocket
    _socket = [[SRWebSocket alloc] initWithURLRequest:request];
    //设置代理
    _socket.delegate = self;
    //开始连接
    [_socket open];
}

#pragma mark -- SRWebSocketDelegate
//收到服务器消息时回调
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"收到服务器消息：%@", message);
    char flag = [message characterAtIndex:[(NSString *)message length] - 1];

    //判断前后两次返回的数据是否相同
    if (!_isFirst && flag == '0') { //相同，直接结束
        NSLog(@"返回消息前后两次相同，不做处理");
        return;
    }

    NSLog(@"返回消息前后两次发生改变,需要更新地图");
    //_message = message;

    NSArray *array = [message componentsSeparatedByString:@","];
    int i = 0, j = 0, k = 0;
    for (; i < 6; i++) {
        if (i % 2 == 0) { //地点
            _locations[j] = array[i];
            j++;
        } else { //人流量
            _numbers[k] = array[i];
            k++;
        }
    }

    [self drawMarker];
    [self drawCircle];
    _isFirst = NO;
}

//连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"连接成功");
}

//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"连接失败");
}

//连接断开
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"close");
}

#pragma mark 进入地图时，设置变量的初始值
//设置经纬度，改变地图镜头位置，同时标志第一次获取服务器信息
- (void)setLatitude:(double)latitude andLongitude:(double)longitude isFirstEnter:(BOOL)isFirst {
    self.latitude = latitude;
    self.longitude = longitude;
    self.isFirst = isFirst;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude); //将地图镜头移动到某一个位置
    self.mapView.zoomLevel = 17;  //缩放等级
}

#pragma mark --点击事件
//拍照识别
- (void)picture_recognition {
    NSLog(@"拍照识别");
    PictureIdentifyViewController *pictureIdentifyPage = [[PictureIdentifyViewController alloc] init];
    [self.navigationController pushViewController:pictureIdentifyPage animated:YES];
}

//显示路线规划view
- (void)road_planning {
    NSLog(@"路线规划");
    bool isShow = [_road_planning_box isDescendantOfView:self.view];
    if (!isShow) {
        [self showRoadPlanningView];
    } else { //隐藏
        _inputStart.text = @"";
        _inputEnd.text = @"";
        [_road_planning_box removeFromSuperview];
    }
}

//景区反馈
- (void)scenic_feedback {
    NSLog(@"景区反馈");
    ScenicFeedbackViewController *scenicFeedbackPage = [[ScenicFeedbackViewController alloc] init];
    [self.navigationController pushViewController:scenicFeedbackPage animated:YES];
}

//景物推送
- (void)scenery_push {
    NSLog(@"景物推送");
    SceneryPushViewController *sceneryPushPage = [[SceneryPushViewController alloc] init];
    [self.navigationController pushViewController:sceneryPushPage animated:YES];
}

//开始进行路线规划
- (void)start_road_planning {
    NSString *start = _inputStart.text;
    NSString *end = _inputEnd.text;
    if (![start isEqualToString:@""] && ![end isEqualToString:@""]) {
        NSLog(@"开始进行路线规划");
        [self drawLineWithStart:start andEnd:end];
    } else {
        NSLog(@"请正确输入起点和终点");
    }
}

#pragma mark --MAMapViewDelegate
//marker回调
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annnotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annnotationView == nil) {
            annnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annnotationView.canShowCallout = YES; //设置气泡可以弹出
        annnotationView.animatesDrop = NO; //设置标注动画显示
        annnotationView.draggable = NO; //设置标注可以拖动
        annnotationView.pinColor = MAPinAnnotationColorGreen;

        return annnotationView;
    }
    return nil;
}

//circle、line
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    //1 line
    if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        //根据圆的大小来设置圆的颜色
        double radius = circleRenderer.circle.radius;
        if (radius <= 6) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.05];
        } else if (radius <= 9) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
        } else if (radius <= 12) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.15];
        } else if (radius <= 15) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
        } else if (radius <= 18) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.25];
        } else if (radius <= 21) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
        } else if (radius <= 24) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.35];
        } else if (radius <= 27) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.4];
        } else if (radius <= 30) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.45];
        } else if (radius <= 33) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
        } else if (radius <= 36) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.55];
        } else if (radius <= 39) {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6];
        } else {
            circleRenderer.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.65];
        }

        return circleRenderer;
    }
    //2 line
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *polyLineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];

        polyLineRenderer.lineWidth = 5.f;
        polyLineRenderer.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.4];
        polyLineRenderer.lineJoin = kCGLineJoinRound;
        polyLineRenderer.lineCap = kCGLineCapRound;

        return polyLineRenderer;
    }

    return nil;
}

#pragma mark --放大缩小地图
- (void)zoomMap {
    self.mapView.zoomLevel += 0.3;
}
- (void)reduceMap {
    self.mapView.zoomLevel -= 0.3;
}

@end
