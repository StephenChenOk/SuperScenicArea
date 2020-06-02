//
//  ViewPointItemInitUtil.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/31.
//

#import "ViewPointItemInitUtil.h"
#import "ViewPointItem.h"
#import "ScenicDescribeUtil.h"

//初始化景点数据工具类
@implementation ViewPointItemInitUtil

//初始化重庆景点数据
+ (NSArray *)getChongqingData {
    ViewPointItem *view1 = [[ViewPointItem alloc] init];
    view1.imgUrl = @"ci_qi_kou";
    view1.name = @"磁器口古镇";
    view1.address = @"重庆市沙坪呗区磁器口古镇";
    view1.scoreText = @"4.6";
    view1.distanceText = @"285.15km";
    view1.latitude = 29.578936;
    view1.longitude = 106.452215;
    view1.detailInfo = [ScenicDescribeUtil getCQK];

    ViewPointItem *view2 = [[ViewPointItem alloc] init];
    view2.imgUrl = @"jie_fang_bei";
    view2.name = @"解放碑步行街";
    view2.address = @"重庆市渝中区解放碑周边区域";
    view2.scoreText = @"4.5";
    view2.distanceText = @"219.15km";
    view2.latitude = 29.557564;
    view2.longitude = 106.577233;
    view2.detailInfo = [ScenicDescribeUtil getJFB];

    ViewPointItem *view3 = [[ViewPointItem alloc] init];
    view3.imgUrl = @"san_qiao";
    view3.name = @"武隆天生三桥";
    view3.address = @"重庆市武隆区仙女山镇游客接待中心";
    view3.scoreText = @"4.6";
    view3.distanceText = @"200.55km";
    view3.latitude = 29.429943;
    view3.longitude = 107.803549;
    view3.detailInfo = [ScenicDescribeUtil getSQ];

    ViewPointItem *view4 = [[ViewPointItem alloc] init];
    view4.imgUrl = @"shi_ke";
    view4.name = @"大足石刻";
    view4.address = @"重庆市大足区宝顶镇大足石刻风景区";
    view4.scoreText = @"4.6";
    view4.distanceText = @"237.15km";
    view4.latitude = 29.74814;
    view4.longitude = 105.795545;
    view4.detailInfo = [ScenicDescribeUtil getDZSK];

    ViewPointItem *view5 = [[ViewPointItem alloc] init];
    view5.imgUrl = @"bai_di_cheng";
    view5.name = @"白帝城景区";
    view5.address = @"奉节县陵门街道办事处白帝城景区";
    view5.scoreText = @"4.5";
    view5.distanceText = @"320.03km";
    view5.latitude = 31.045283;
    view5.longitude = 109.571948;
    view5.detailInfo = [ScenicDescribeUtil getBDC];

    ViewPointItem *view6 = [[ViewPointItem alloc] init];
    view6.imgUrl = @"suo_dao";
    view6.name = @"长江索道";
    view6.address = @"重庆市渝中区新华路151号";
    view6.scoreText = @"4.4";
    view6.distanceText = @"257.53km";
    view6.latitude = 29.556249;
    view6.longitude = 106.586634;
    view6.detailInfo = [ScenicDescribeUtil getCJSD];

    ViewPointItem *view7 = [[ViewPointItem alloc] init];
    view7.imgUrl = @"nan_shan";
    view7.name = @"南山风景区";
    view7.address = @"重庆市南岸区南山镇南山公园附近";
    view7.scoreText = @"4.4";
    view7.distanceText = @"140.15km";
    view7.latitude = 29.556989;
    view7.longitude = 106.623053;
    view7.detailInfo = [ScenicDescribeUtil getNS];

    ViewPointItem *view8 = [[ViewPointItem alloc] init];
    view8.imgUrl = @"bai_gong_guan";
    view8.name = @"白公馆";
    view8.address = @"沙坪坝区壮志路治法三村63号";
    view8.scoreText = @"4.2";
    view8.distanceText = @"198.15km";
    view8.latitude = 29.576473;
    view8.longitude = 106.432065;
    view8.detailInfo = [ScenicDescribeUtil getBGG];

    return [NSArray arrayWithObjects:view1, view2, view3, view4, view5, view6, view7, view8, nil];
}

//初始化上海景点数据
+ (NSArray *)getShanghaiData {
    ViewPointItem *view1 = [[ViewPointItem alloc] init];
    view1.imgUrl = @"wai_tan";
    view1.name = @"外滩";
    view1.address = @"上海黄浦区中山东一路（临黄浦江）";
    view1.scoreText = @"4.8";
    view1.distanceText = @"385.15km";
    view1.latitude = 31.233462;
    view1.longitude = 121.492156;
    view1.detailInfo = [ScenicDescribeUtil getWT];

    ViewPointItem *view2 = [[ViewPointItem alloc] init];
    view2.imgUrl = @"di_shi_ni";
    view2.name = @"上海迪士尼度假区";
    view2.address = @"上海市浦东新区川沙新镇上海迪士尼度假区";
    view2.scoreText = @"4.6";
    view2.distanceText = @"359.35km";
    view2.latitude = 31.141269;
    view2.longitude = 121.661699;
    view2.detailInfo = [ScenicDescribeUtil getDSN];

    ViewPointItem *view3 = [[ViewPointItem alloc] init];
    view3.imgUrl = @"nan_jing_lu_bxj";
    view3.name = @"南京路步行街";
    view3.address = @"上海市黄浦区河南中路";
    view3.scoreText = @"4.6";
    view3.distanceText = @"320.55km";
    view3.latitude = 31.235986;
    view3.longitude = 121.479503;
    view3.detailInfo = [ScenicDescribeUtil getNJL_BXJ];

    ViewPointItem *view4 = [[ViewPointItem alloc] init];
    view4.imgUrl = @"chang_feng";
    view4.name = @"上海长风海洋世界";
    view4.address = @"普陀区大渡河路451号（长风公园4号门）";
    view4.scoreText = @"4.5";
    view4.distanceText = @"337.06km";
    view4.latitude = 31.225079;
    view4.longitude = 121.397016;
    view4.detailInfo = [ScenicDescribeUtil getCF_HYSJ];

    ViewPointItem *view5 = [[ViewPointItem alloc] init];
    view5.imgUrl = @"zj_jz";
    view5.name = @"朱家角古镇景区";
    view5.address = @"上海市青浦区朱家角镇";
    view5.scoreText = @"4.4";
    view5.distanceText = @"389.93km";
    view5.latitude = 31.109319;
    view5.longitude = 121.052951;
    view5.detailInfo = [ScenicDescribeUtil getZJJ];

    return [NSArray arrayWithObjects:view1, view2, view3, view4, view5, nil];
}

@end
