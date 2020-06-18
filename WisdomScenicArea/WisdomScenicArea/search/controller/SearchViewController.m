//
//  SearchViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import "SearchViewController.h"
#import "ScreenUtil.h"
#import "QFTextField.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "POITableViewCell.h"
#import "PoiItem.h"
#import "MapViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SearchViewController ()<UITextFieldDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong,readwrite)UITableView *tableView;
@property (nonatomic, strong, readwrite) UIView *searchBox;
@property (nonatomic, strong, readwrite) QFTextField *searchText;

@property (nonatomic, strong, readwrite) AMapSearchAPI *searchAPI;
@property (nonatomic, strong, readwrite) NSMutableArray<PoiItem*> *dataArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"搜索";

    [self showSearchView];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = self;
    _dataArray = [NSMutableArray arrayWithCapacity:8];
}

#pragma mark -- 显示搜索框
- (void)showSearchView {
    _searchText = [[QFTextField alloc] initWithFrame:UIRect(47, 47, 320, 32)];
    _searchText.delegate = self;
    _searchText.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_pressed"]];
    _searchText.leftViewMode = UITextFieldViewModeUnlessEditing;
    _searchText.clearButtonMode = UITextFieldViewModeAlways;
    _searchText.placeholder = @"输入景区/城市搜索";
    _searchText.borderStyle = UITextBorderStyleRoundedRect;//边框圆角

    self.navigationItem.titleView = _searchText;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //2
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *name = textField.text;
    if(name.length > 0){
        [self search:textField.text];
    }else{
        [_tableView removeFromSuperview];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //常用业务逻辑 - 字数判断 可以在此函数中实现
    return YES;
}

#pragma mark -- 开始搜索
- (void)search:(NSString *)name {
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hub.label.text = @"搜索中";
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];

    request.keywords = name;
    request.city = @"桂林";
    request.requireExtension = YES;

    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit = YES;
    request.requireSubPOIs = YES;

    [_searchAPI AMapPOIKeywordsSearch:request];
}

//POI 搜索回调.
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) {
        NSLog(@"未搜索到要查找到地点");
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        return;
    }

    for(AMapPOI *poi in response.pois){
        NSString *address =[NSString stringWithFormat:@"%@%@%@",poi.province,poi.city,poi.address];
        PoiItem *item = [[PoiItem alloc] initWithName:poi.name andAddress:address andLatitude:poi.location.latitude andLongitude:poi.location.longitude];
        [_dataArray addObject:item];
    }

    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

#pragma mark -- UITableViewDelegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    POITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"POITableViewCell"];
    if(!cell){
        cell = [[POITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"POITableViewCell"];
    }
    [cell setDataInCellWithItem:_dataArray[indexPath.row] andIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PoiItem *item = [_dataArray objectAtIndex:indexPath.row];
    MapViewController *mapPage = [[MapViewController alloc] init];
    [mapPage setLatitude:item.latitude andLongitude:item.longitude isFirstEnter:YES];
    [self.navigationController pushViewController:mapPage animated:YES];
}

@end
