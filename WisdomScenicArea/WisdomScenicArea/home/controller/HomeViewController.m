//
//  HomeViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/20.
//  Copyright © 2020 chen. All rights reserved.
//

#import "HomeViewController.h"
#import "BannerView.h"
#import "HomeItemTableViewCell.h"
#import "HomeItem.h"
#import "UIColor+TransformColor.h"
#import "MapViewController.h"
#import "ScreenUtil.h"



@interface HomeViewController ()<BannerViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readwrite) NSMutableArray *bannerImage;
@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *datas;

@end

@implementation HomeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBarItem.title = @"主页";
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_selected"];
        self.title = @"主页";
        self.navigationController.navigationBar.barTintColor = [UIColor greenColor];

        [self.view addSubview:({
            UIImageView *weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(UI(44), UI(STATUSBAR_HEIGHT+44+268), UI(50), UI(50))];
            [weatherImg setImage:[UIImage imageNamed:@"weather_logo"]];
            weatherImg;
        })];
        [self.view addSubview:({
            UILabel *weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI(36), UI(STATUSBAR_HEIGHT+44+321), UI(66), UI(20))];
            weatherLabel.text = @"实时天气";
            weatherLabel.font = [UIFont systemFontOfSize:UI(16)];
            weatherLabel;
        })];
        [self.view addSubview:({
            UIImageView *weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(UI(180), UI(STATUSBAR_HEIGHT+44+268), UI(50), UI(50))];
            [weatherImg setImage:[UIImage imageNamed:@"translation_logo"]];
            weatherImg;
        })];
        [self.view addSubview:({
            UILabel *translationLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI(174), UI(STATUSBAR_HEIGHT+44+321), UI(66), UI(20))];
            translationLabel.text = @"在线翻译";
            translationLabel.font = [UIFont systemFontOfSize:UI(16)];
            translationLabel;
        })];
        [self.view addSubview:({
            UIImageView *wcImg = [[UIImageView alloc] initWithFrame:CGRectMake(UI(318), UI(STATUSBAR_HEIGHT+44+268), UI(50), UI(50))];
            [wcImg setImage:[UIImage imageNamed:@"wc_logo"]];
            wcImg;
        })];
        [self.view addSubview:({
            UILabel *wcLabel = [[UILabel alloc] initWithFrame:CGRectMake(UI(310), UI(STATUSBAR_HEIGHT+44+321), UI(66), UI(20))];
            wcLabel.text = @"附近厕所";
            wcLabel.font = [UIFont systemFontOfSize:UI(16)];
            wcLabel;
        })];
        [self.view addSubview:({
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(UI(0), UI(STATUSBAR_HEIGHT+44+357), UI(414), UI(1))];
            line.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
            line;
        })];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBannerImages];
    [self initBannerView];
    [self initHomeItemDatas];
    [self initTableView];
}

#pragma mark initView
//初始化轮播图
- (void)initBannerView {
    BannerView *banner = [[BannerView alloc]initWithFrame:UIRect(0, STATUSBAR_HEIGHT+44, 414, 250) andImageNameArray:self.bannerImage andIsRunning:YES];
    banner.delegate = self;
    [self.view addSubview:banner];
}

//初始化tableView
- (void)initTableView {
    _tableView = [[UITableView alloc] initWithFrame:UIRect(0, STATUSBAR_HEIGHT+44+357, 414, 360)];
    //设置当底下没内容后，不显示任何东西
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view  addSubview:_tableView];
}

#pragma mark initData
//初始化轮播图图片资源
- (void)initBannerImages {
    self.bannerImage = [NSMutableArray arrayWithObjects:@"elephant_hill", @"sjg", @"slzx", @"kz_ruins", @"px_town", nil];
}

//初始化home item数据
- (void)initHomeItemDatas {
    HomeItem *item1 = [[HomeItem alloc] init];
    item1.imgUrl = @"elephant_hill";
    item1.name = @"象鼻山";
    item1.address = @"广西省桂林市象山景区";
    item1.views = @"550";
    item1.distance = @"30.15km";
    item1.latitude = 25.267088;
    item1.logitude = 110.296427;

    HomeItem *item2 = [[HomeItem alloc] init];
    item2.imgUrl = @"px_town";
    item2.name = @"普贤塔";
    item2.address = @"广西省桂林市象山景区";
    item2.views = @"325";
    item2.distance = @"29.59km";
    item2.latitude = 25.267242;
    item2.logitude = 110.296046;

    HomeItem *item3 = [[HomeItem alloc] init];
    item3.imgUrl = @"jng";
    item3.name = @"太平天国纪念馆";
    item3.address = @"广西省桂林市象山景区";
    item3.views = @"324";
    item3.distance = @"28.03km";
    item3.latitude = 25.266431;
    item3.logitude = 110.295181;

    HomeItem *item4 = [[HomeItem alloc] init];
    item4.imgUrl = @"yfs";
    item4.name = @"云峰寺";
    item4.address = @"广西省桂林市象山景区";
    item4.views = @"291";
    item4.distance = @"27.79km";
    item4.latitude = 25.266559;
    item4.logitude = 110.295011;

    _datas = [NSArray arrayWithObjects:item1, item2, item3, item4, nil];
}

#pragma mark TJXViewDelegate
- (void)sendImageName:(BannerView *)banner andName:(NSInteger)selectImage {
    NSLog(@"%ld", (long)selectImage);
}

#pragma mark UITableViewDelegate
//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UI(110);
}

//点击item
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeItem *item = [_datas objectAtIndex:indexPath.row];
    MapViewController *mapViewPage = [[MapViewController alloc] init];
    [mapViewPage setLatitude:item.latitude andLongitude:item.logitude isFirstEnter:YES];
    [self.navigationController pushViewController:mapViewPage animated:YES];
}

#pragma mark UITableViewDataSource
//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeItemTableViewCell"];
    if (!cell) {
        cell = [[HomeItemTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HomeItemTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    HomeItem *item = [_datas objectAtIndex:indexPath.row];
    [cell setDataInCellWithItem:item];

    return cell;
}

@end
