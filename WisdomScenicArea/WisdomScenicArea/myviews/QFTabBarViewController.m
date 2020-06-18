//
//  QFTabBarViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import "QFTabBarViewController.h"
#import "UIColor+TransformColor.h"
#import "ScreenUtil.h"
#import "SearchViewController.h"

@interface QFTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong, readwrite) UIView *searchBox;

@end

@implementation QFTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.delegate = self;
    [self showSearchView];
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    //self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
}

#pragma mark -- 显示搜索框
- (void)showSearchView {
    _searchBox = [[UIView alloc] initWithFrame:UIRect(47, 47, 320, 32)];

    //设置圆角半径为方形边长一半
    [_searchBox.layer setCornerRadius:7];
    [_searchBox.layer setMasksToBounds:YES];

    //设置边框宽度和颜色
    [_searchBox.layer setBorderWidth:1];
    [_searchBox.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

    [_searchBox addSubview:({
        UIImageView *searchLogo = [[UIImageView alloc] initWithFrame:UIRect(6, 6, 20, 20)];
        searchLogo.image = [UIImage imageNamed:@"search_pressed"];
        searchLogo;
    })];
    [_searchBox addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:UIRect(36, 3, 265, 25)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:UI(15)];
        label.text = @"输入景区/城市搜索";
        label;
    })];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoSearchPage)];
    [_searchBox addGestureRecognizer:tap];
    _searchBox.userInteractionEnabled = YES;
    
    self.navigationItem.titleView = _searchBox;
}

#pragma mark -- 底部tarbar点击回调
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (item.tag) {
        case 1:
            self.navigationItem.titleView = _searchBox;
            break;
        case 2:
            self.navigationItem.titleView = _searchBox;
            break;
        case 3:
            self.navigationItem.titleView = nil;
            break;
        default:
            NSLog(@"error");
            break;
    }
}

#pragma mark -- 进行搜索
- (void)gotoSearchPage{
    SearchViewController *searchPage = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchPage animated:YES];
}

@end
