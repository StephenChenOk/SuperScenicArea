//
//  AStarUtils.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/30.
//

#import "AStarUtils.h"
#import "RoadPlanningUtil.h"

//使用AStar算法生成相应的路线
@implementation AStarUtils

//指定一个范围，乘以人流量数据，作为人流量影响的一个标准
//云峰寺
double latitude1;
double longtitude1;
//太平天国纪念馆
double latitude2;
double longtitude2;

RoadPlanningUtil *util;

- (instancetype)init
{
    self = [super init];
    if (self) {
        latitude1 = 25.266559;
        longtitude1 = 110.295011;
        latitude2 = 25.266431;
        longtitude2 = 110.295181;
        util = [[RoadPlanningUtil alloc] init];
    }
    return self;
}

- (NSString *)A_Star:(int *)numbers start:(NSString *)start end:(NSString *)end {
    if ([start isEqualToString:@"醉乡"] && [end isEqualToString:@"普贤塔"]) {
        switch ([self zxToTown:numbers]) {
            case 0:
                return @"zxToTown_road1";
                break;
            case 1:
                return @"zxToTown_road2";
                break;
            case 2:
                return @"zxToTown_road3";
                break;
            default:
                return @"";
                break;
        }
    }
    if ([start isEqualToString:@"醉乡"] && [end isEqualToString:@"象眼岩"]) {
        switch ([self zxToTown:numbers]) {
            case 0:
                return @"zxToRock_road1";
                break;
            case 1:
                return @"zxToRock_road2";
                break;
            case 2:
                return @"zxToRock_road3";
                break;
            default:
                return @"";
                break;
        }
    }
    if ([start isEqualToString:@"醉乡"] && [end isEqualToString:@"桂林抗战遗址"]) {
        return @"zxToRuins_road";
    }
    if ([start isEqualToString:@"云峰寺"] && [end isEqualToString:@"普贤塔"]) {
        switch ([self zxToTown:numbers]) {
            case 0:
                return @"yfsToTown_road1";
                break;
            case 1:
                return @"";
                break;
            case 2:
                return @"yfsToTown_road2";
                break;
            default:
                return @"";
                break;
        }
    }
    if ([start isEqualToString:@"云峰寺"] && [end isEqualToString:@"象眼岩"]) {
        switch ([self zxToTown:numbers]) {
            case 0:
                return @"yfsToRock_road1";
                break;
            case 1:
                return @"yfsToRock_road2";
                break;
            case 2:
                return @"yfsToRock_road3";
                break;
            default:
                return @"";
                break;
        }
    }
    if ([start isEqualToString:@"云峰寺"] && [end isEqualToString:@"桂林抗战遗址"]) {
        return @"yfsToRuins_road";
    }
    if ([start isEqualToString:@"象山钟韵"] && [end isEqualToString:@"普贤塔"]) {
        return @"zyToTown_road";
    }
    if ([start isEqualToString:@"象山钟韵"] && [end isEqualToString:@"象眼岩"]) {
        switch ([self zyToRock:numbers]) {
            case 0:
                return @"zyToRock_road1";
                break;
            case 1:
                return @"zyToRock_road2";
                break;
            case 2:
                return @"zyToRock_road3";
                break;
            default:
                return @"";
                break;
        }
    }
    if ([start isEqualToString:@"象山钟韵"] && [end isEqualToString:@"桂林抗战遗址"]) {
        switch ([self zyToRuins:numbers]) {
            case 0:
                return @"zyToRuins_road1";
                break;
            case 1:
                return @"";
                break;
            case 2:
                return @"zyToRuins_road2";
                break;
            default:
                return @"";
                break;
        }
    }
    
    return @"";
}

//醉乡-->普贤塔
- (int)zxToTown:(int [])numbers {
    double f_n[] = { 0, 0, 0 };
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:   //到普贤塔的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zxToTown_road1] withNumber:numbers[i]];
                break;
            case 1:   //到象眼岩的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zxToTown_road2] withNumber:numbers[i]];
                break;
            case 2:   //到桂林抗战遗址的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zxToTown_road3] withNumber:numbers[i]];
                break;
        }
    }
    //求出总代价最小的路线id
    return [self getMinCostRoadId:f_n];
}

//醉乡-->象眼岩
- (int)zxToRock:(int [])numbers {
    double f_n[] = { 0, 0, 0 };
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:   //到普贤塔的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zxToRock_road1] withNumber:numbers[i]];
                break;
            case 1:   //到象眼岩的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zxToRock_road2] withNumber:numbers[i]];
                break;
            case 2:   //到桂林抗战遗址的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zxToRock_road3] withNumber:numbers[i]];
                break;
        }
    }
    //求出总代价最小的路线id
    return [self getMinCostRoadId:f_n];
}

//云峰寺-->普贤塔
- (int)yfsToTown:(int [])numbers {
    double f_n[] = { 0, 0, 0 };
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:   //到普贤塔的代价
                //求得总代价
                f_n[i] = [self getF_n:[util yfsToTown_road1] withNumber:numbers[i]];
                break;
            case 1:   //到象眼岩的代价
                //求得总代价
                f_n[i] = 1000000;
                break;
            case 2:   //到桂林抗战遗址的代价
                //求得总代价
                f_n[i] = [self getF_n:[util yfsToTown_road2] withNumber:numbers[i]];
                break;
        }
    }
    //求出总代价最小的路线id
    return [self getMinCostRoadId:f_n];
}

//云峰寺-->象眼岩
- (int)yfsToRock:(int [])numbers {
    double f_n[] = { 0, 0, 0 };
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:   //到普贤塔的代价
                //求得总代价
                f_n[i] = [self getF_n:[util yfsToRock_road1] withNumber:numbers[i]];
                break;
            case 1:   //到象眼岩的代价
                //求得总代价
                f_n[i] = [self getF_n:[util yfsToRock_road2] withNumber:numbers[i]];
                break;
            case 2:   //到桂林抗战遗址的代价
                //求得总代价
                f_n[i] = [self getF_n:[util yfsToRock_road3] withNumber:numbers[i]];
                break;
        }
    }
    //求出总代价最小的路线id
    return [self getMinCostRoadId:f_n];
}

//象山钟韵-->象眼岩
- (int)zyToRock:(int [])numbers {
    double f_n[] = { 0, 0, 0 };
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:   //到普贤塔的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zyToRock_road1] withNumber:numbers[i]];
                break;
            case 1:   //到象眼岩的代价
                 //求得总代价
                f_n[i] = [self getF_n:[util zyToRock_road2] withNumber:numbers[i]];
                break;
            case 2:   //到桂林抗战遗址的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zyToRock_road3] withNumber:numbers[i]];
                break;
        }
    }
    //求出总代价最小的路线id
    return [self getMinCostRoadId:f_n];
}

//象山钟韵-->桂林抗战遗址
- (int)zyToRuins:(int [])numbers {
    double f_n[] = { 0, 0, 0 };
    for (int i = 0; i < 3; i++) {
        switch (i) {
            case 0:   //到普贤塔的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zyToRuins_road1] withNumber:numbers[i]];
                break;
            case 1:   //到象眼岩的代价
                 //求得总代价
                f_n[i] = 1000000;
                break;
            case 2:   //到桂林抗战遗址的代价
                //求得总代价
                f_n[i] = [self getF_n:[util zyToRuins_road2] withNumber:numbers[i]];
                break;
        }
    }
    //求出总代价最小的路线id
    return [self getMinCostRoadId:f_n];
}

//根据给定路线及人流量计算出总代价
- (int)getF_n:(CLLocationCoordinate2D *)points withNumber:(int)number {
    int j = 1;
    int g_n = 0;
    int f_n, h_n;
    while (points[j].latitude != 0) {
        CLLocationCoordinate2D curPoint = points[j];
        CLLocationCoordinate2D prePoint = points[j - 1];
        //1 求g(n)，路线长度的代价（使用经纬度计算）
        g_n += sqrt((curPoint.latitude - prePoint.latitude) * (curPoint.latitude - prePoint.latitude)
                    + (curPoint.longitude - prePoint.longitude) * (curPoint.longitude - prePoint.longitude));
        j++;
    }
    //2 求h(n)，人流量影响的代价
    number = number / 10;
    if (number == 0) {
        number = 1;
    }
    h_n = number * sqrt((latitude1 - latitude2) * (latitude1 - latitude2) + (longtitude1 - longtitude2) * (longtitude1 - longtitude2));
    //3 求f(n)，总代价
    f_n = g_n + h_n;
    return f_n;
}

//根据路线的总代价，求出总代价最小的路线id
- (int)getMinCostRoadId:(double [])f_n {
    double temp = f_n[0];
    int minFlag = 0;
    for (int i = 0; i < 3; i++) {
        if (f_n[i] < temp) {
            temp = f_n[i];
            minFlag = i;
        }
    }
    return minFlag;
}

@end
