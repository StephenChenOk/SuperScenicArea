//
//  ViewPointViewController.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import "ViewPointViewController.h"
#import "ViewPointTableViewCell.h"
#import "ViewPointItem.h"
#import "ViewPointDetailViewController.h"
#import "ViewPointItemInitUtil.h"
#import "MapViewController.h"

@interface ViewPointViewController ()<UITableViewDelegate, UITableViewDataSource,DetailDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong, readwrite) NSArray *datas;

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
    return 120;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
//初始化重庆景点数据
- (void)initChongqingData {
    self.datas = [ViewPointItemInitUtil getChongqingData];
}

//初始化上海景点数据
- (void)initShanghaiData {
    self.datas = [ViewPointItemInitUtil getShanghaiData];
}

#pragma mark --DetailDelegate跳转详情界面
- (void)gotoDetailPageWithIndex:(NSInteger)index{
    ViewPointDetailViewController *detailViewController = [[ViewPointDetailViewController alloc] init];
    [detailViewController initDetailData:[_datas objectAtIndex:index]];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
