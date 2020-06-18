//
//  SceneryPushViewController.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/28.
//

#import "SceneryPushViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ScenicDescribeUtil.h"
#import "ScreenUtil.h"

//景物推送
@interface SceneryPushViewController ()

@property (nonatomic, strong, readwrite) UILabel *lbName;
@property (nonatomic, strong, readwrite) UIImageView *ivPicture;
@property (nonatomic, strong, readwrite) UITextView *tvInfo;

@end

@implementation SceneryPushViewController

- (instancetype)initWithSceneryName:(NSString *)name{
    self = [super init];
    if (self) {
        [self initView];
        [self setSceneryPicAndInfo:name];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark 初始化view
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"景物推送";

    [self.view addSubview:({
        _lbName = [[UILabel alloc] initWithFrame:UIRect(151, STATUSBAR_HEIGHT + 44 + 18, 111, 35)];
        _lbName.font = [UIFont systemFontOfSize:UI(20)];
        _lbName.textAlignment = NSTextAlignmentCenter;
        _lbName;
    })];

    [self.view addSubview:({
        _ivPicture = [[UIImageView alloc] initWithFrame:UIRect(67, STATUSBAR_HEIGHT + 44 + 63, 280, 230)];
        _ivPicture.image = [UIImage imageNamed:@"sjg"];

        _ivPicture.userInteractionEnabled = true;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click_picture)];
        [_ivPicture addGestureRecognizer:tapGesture];

        _ivPicture;
    })];

    [self.view addSubview:({
        _tvInfo = [[UITextView alloc] initWithFrame:CGRectMake(UI(20), UI(STATUSBAR_HEIGHT + 44 + 314), UI(374), self.view.bounds.size.height-UI(STATUSBAR_HEIGHT + 44 + 314)-UI(20))];
        _tvInfo.font = [UIFont systemFontOfSize:16];
        [_tvInfo setEditable:NO];  //使其不能编辑
        //设置内边距
        _tvInfo.textContainerInset = UIEdgeInsetsMake(UI(5), UI(5), UI(5), UI(5));

        //设置圆角半径为方形边长一半
        [_tvInfo.layer setCornerRadius:UI(10)];
        [_tvInfo.layer setMasksToBounds:YES];

        //设置边框宽度和颜色
        [_tvInfo.layer setBorderWidth:0.5];
        [_tvInfo.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

        _tvInfo;
    })];
}

- (void)setSceneryPicAndInfo:(NSString *)name{
    if([name isEqualToString:@"水晶宫"]){
        _ivPicture.image = [UIImage imageNamed:@"sjg"];
        _tvInfo.text = [ScenicDescribeUtil getSJG];
    }
    if([name isEqualToString:@"狮岭朝霞"]){
        _ivPicture.image = [UIImage imageNamed:@"slzx"];
        _tvInfo.text = [ScenicDescribeUtil getSLZX];
    }
    if([name isEqualToString:@"红罗宝帐"]){
        _ivPicture.image = [UIImage imageNamed:@"hlbz"];
        _tvInfo.text = [ScenicDescribeUtil getHLBZ];
    }
    _lbName.text = name;
}

#pragma mark 点击事件
- (void)click_picture {
    NSLog(@"点击图片");
}

@end
