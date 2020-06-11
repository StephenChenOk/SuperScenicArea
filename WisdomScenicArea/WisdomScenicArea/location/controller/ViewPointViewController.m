//
//  ViewPointViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import "ViewPointViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ViewPointTableViewCell.h"
#import "ViewPointItem.h"
#import "ViewPointDetailViewController.h"
#import "ViewPointItemInitUtil.h"
#import "MapViewController.h"
#import "ScreenUtil.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewPointViewController ()<UITableViewDelegate, UITableViewDataSource, DetailDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *datas;

@property (nonatomic, strong, readwrite) NSDictionary *todayWeather;
@property (nonatomic, strong, readwrite) NSDictionary *tomorrowWeather;

@end

@implementation ViewPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    //设置当底下没内容后，不显示任何东西
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

//设置顶部标题
- (void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}

#pragma mark UITableViewDelegate

//每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UI(120);
}

//点击item
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewPointItem *item = [_datas objectAtIndex:indexPath.row];
    MapViewController *mapViewPage = [[MapViewController alloc] init];
    [mapViewPage setLatitude:item.latitude andLongitude:item.longitude isFirstEnter:YES];
    [self.navigationController pushViewController:mapViewPage animated:YES];
}

#pragma mark UITableViewDataSource
//行数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _datas.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewPointTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ViewPointTableViewCell"];
    if (!cell) {
        cell = [[ViewPointTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ViewPointTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }

    ViewPointItem *item = [_datas objectAtIndex:indexPath.row];
    [cell setDataInCellWithItem:item andIndex:indexPath.row];

    return cell;
}

#pragma mark 初始化景点数据
//初始化景点数据
- (void)initViewPointDataWithCity:(NSString *)city {
    if([city isEqualToString:@"重庆"]){
        self.datas = [ViewPointItemInitUtil getChongqingData];
    }else if([city isEqualToString:@"上海"]){
        self.datas = [ViewPointItemInitUtil getShanghaiData];
    }else{
        return;
    }
    //获取天气信息
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getWeatherDatasWithCity:city];
}

#pragma mark --DetailDelegate跳转详情界面
- (void)gotoDetailPageWithIndex:(NSInteger)index {
    ViewPointDetailViewController *detailViewController = [[ViewPointDetailViewController alloc] init];
    [detailViewController initDetailData:[_datas objectAtIndex:index]];
    if(_todayWeather != nil && _tomorrowWeather != nil){
        [detailViewController setTodayWeather:_todayWeather];
        [detailViewController setTomorrowWeather:_tomorrowWeather];
    }
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -- 获取天气数据
- (void)getWeatherDatasWithCity:(NSString *)city {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //参数
    NSDictionary *parameters = @{ @"city": city, @"key": @"899b282681c66e86ab1d97b388fa9b69" };

    __weak typeof(self) weakSelf = self;
    [manager GET:@"http://apis.juhe.cn/simpleWeather/query" parameters:parameters success:^(AFHTTPRequestOperation *_Nonnull operation, id _Nullable responseObject) {
        NSString *response = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"获取天气数据成功----> %@", response);

        id jsonObj = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSDictionary *result = [(NSDictionary *)jsonObj objectForKey:@"result"];
        weakSelf.todayWeather = [result objectForKey:@"realtime"];
        NSArray *futureArray = [result objectForKey:@"future"];
        weakSelf.tomorrowWeather = futureArray[0];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *_Nullable operation, NSError *_Nonnull error) {
        if (error) {
            NSLog(@"获取天气数据失败");
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

@end
