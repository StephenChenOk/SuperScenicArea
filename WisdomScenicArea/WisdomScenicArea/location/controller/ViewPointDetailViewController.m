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
#import "ScreenUtil.h"

@interface ViewPointDetailViewController (){
    NSString *_humidity;
}

@property (nonatomic, strong, readwrite) UIImageView *ivImage;
@property (nonatomic, strong, readwrite) QFLabelView *lbInfo;
@property (nonatomic, strong, readwrite) UIScrollView *scrollView;

@property (nonatomic, strong, readwrite) UILabel *lbToday;
@property (nonatomic, strong, readwrite) UILabel *lbTomorrow;

//天气
@property (nonatomic, strong, readwrite) UIImageView *weatherLogo;
@property (nonatomic, strong, readwrite) UILabel *weatherLabel;
//温度
@property (nonatomic, strong, readwrite) UIImageView *temperatureLogo;
@property (nonatomic, strong, readwrite) UILabel *temperatureLabel;
//湿度
@property (nonatomic, strong, readwrite) UIImageView *humidityLogo;
@property (nonatomic, strong, readwrite) UILabel *humidityLabel;
//风向
@property (nonatomic, strong, readwrite) UIImageView *directLogo;
@property (nonatomic, strong, readwrite) UILabel *directLabel;

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
}

- (void)viewWillAppear:(BOOL)animated{
     [self loadTodayWeather];
}

//初始化景点详情信息
- (void)initDetailData:(ViewPointItem *)item {
    self.navigationItem.title = item.name;
    self.navigationItem.leftBarButtonItem.width = 10;
    self.ivImage.image = [UIImage imageNamed:item.imgUrl];

    //根据label中内容的大小自适应label大小
    self.lbInfo.text = item.detailInfo;
    CGSize labelSize = [item.detailInfo boundingRectWithSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width * 3) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  | NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:UI(16)] } context:nil].size;
    self.lbInfo.frame = CGRectMake(UI(3), UI(534), ceil(labelSize.width-3), ceil(labelSize.height + 100) );

    
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
            _weatherLogo = [[UIImageView alloc] initWithFrame:UIRect(85, 323, 40, 40)];
            _weatherLogo;
        })];
        [_scrollView addSubview:({
            _weatherLabel = [[UILabel alloc] initWithFrame:UIRect(55, 367, 100, 21)];
            _weatherLabel.font = [UIFont systemFontOfSize:UI(16)];
            _weatherLabel.textAlignment = NSTextAlignmentCenter;
            _weatherLabel;
        })];
        [_scrollView addSubview:({
            _temperatureLogo = [[UIImageView alloc] initWithFrame:UIRect(294, 323, 38, 38)];
            _temperatureLogo.image = [UIImage imageNamed:@"temperature"];
            _temperatureLogo;
        })];
        [_scrollView addSubview:({
            _temperatureLabel = [[UILabel alloc] initWithFrame:UIRect(263, 367, 100, 21)];
            _temperatureLabel.font = [UIFont systemFontOfSize:UI(16)];
            _temperatureLabel.textAlignment = NSTextAlignmentCenter;
            _temperatureLabel;
        })];
        [_scrollView addSubview:({
            _humidityLogo = [[UIImageView alloc] initWithFrame:UIRect(85, 409, 39, 39)];
            _humidityLogo.image = [UIImage imageNamed:@"humidity"];
            _humidityLogo;
        })];
        [_scrollView addSubview:({
            _humidityLabel = [[UILabel alloc] initWithFrame:UIRect(55, 452, 100, 21)];
            _humidityLabel.font = [UIFont systemFontOfSize:UI(16)];
            _humidityLabel.textAlignment = NSTextAlignmentCenter;
            _humidityLabel;
        })];
        [_scrollView addSubview:({
            _directLogo = [[UIImageView alloc] initWithFrame:UIRect(294, 409, 39, 39)];
            _directLogo.image = [UIImage imageNamed:@"direct"];
            _directLogo;
        })];
        [_scrollView addSubview:({
            _directLabel = [[UILabel alloc] initWithFrame:UIRect(233, 452, 160, 21)];
            _directLabel.font = [UIFont systemFontOfSize:UI(16)];
            _directLabel.textAlignment = NSTextAlignmentCenter;
            _directLabel;
        })];
        [_scrollView addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:UIRect(0, 484, 414, 10)];
            line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
            line;
        })];
        [_scrollView addSubview:({
            UILabel *label = [[UILabel alloc] initWithFrame:UIRect(157, 504, 100, 21)];
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

#pragma mark -- 添加天气信息
- (void)loadTodayWeather{
    NSLog(@"loadTodayWeather");
    NSString *weather = [_todayWeather objectForKey:@"info"];
    _weatherLabel.text = weather;
    [self setWeatherLogoWithName:weather];
    
    _temperatureLabel.text = [_todayWeather objectForKey:@"temperature"];
    _humidity = [_todayWeather objectForKey:@"humidity"];
    _humidityLabel.text = _humidity;
    _directLabel.text = [_todayWeather objectForKey:@"direct"];
}
- (void)loadTomorrowWeather{
    NSString *weather = [_tomorrowWeather objectForKey:@"weather"];
    _weatherLabel.text = weather;
    [self setWeatherLogoWithName:weather];
    
    _temperatureLabel.text = [_tomorrowWeather objectForKey:@"temperature"];
    _humidityLabel.text = [NSString stringWithFormat:@"%d",[_humidity intValue]+3];
    _directLabel.text = [_tomorrowWeather objectForKey:@"direct"];
}

- (void)setWeatherLogoWithName:(NSString *)name{
    if([name isEqualToString:@"晴"]){
        _weatherLogo.image = [UIImage imageNamed:@"sun"];
    }else if([name isEqualToString:@"多云"]){
        _weatherLogo.image = [UIImage imageNamed:@"yin"];
    }else if([name isEqualToString:@"阴"]){
        _weatherLogo.image = [UIImage imageNamed:@"yin"];
    }else if([name containsString:@"雪"]){
        _weatherLogo.image = [UIImage imageNamed:@"snow"];
    }else if([name containsString:@"雨"]){
        _weatherLogo.image = [UIImage imageNamed:@"rain"];
    }else{
        _weatherLogo.image = [UIImage imageNamed:@"yin"];
    }
}

#pragma mark --点击事件
- (void)today_weather{
    _lbTomorrow.textColor = [UIColor blackColor];
    _lbToday.textColor = [UIColor colorWithRGB:0x5abce3 lpha:1];
    [self loadTodayWeather];
}

- (void)tomorrow_weather{
    _lbToday.textColor = [UIColor blackColor];
    _lbTomorrow.textColor = [UIColor colorWithRGB:0x5abce3 lpha:1];
    [self loadTomorrowWeather];
}

@end
