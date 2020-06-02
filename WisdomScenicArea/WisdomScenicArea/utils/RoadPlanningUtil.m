//
//  RoadPlanningUtil.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/29.
//

//生成路线规划的工具类
#import "RoadPlanningUtil.h"
#import <MAMapKit/MAMapKit.h>

@implementation RoadPlanningUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark 醉乡-->普贤塔
//途经普贤塔
- (CLLocationCoordinate2D *)zxToTown_road1 {
    static CLLocationCoordinate2D lineCoords[11];  //static表明当前变量的生命周期为整个application的周期，如果是定位为普通
                                                   //局部变量，在方法执行完毕后变量地址会被销毁，所返回的指针变成野指针

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266453;
    lineCoords[1].longitude = 110.295620;

    lineCoords[2].latitude = 25.266413;
    lineCoords[2].longitude = 110.295356;

    lineCoords[3].latitude = 25.266510;
    lineCoords[3].longitude = 110.295420;

    lineCoords[4].latitude = 25.266820;
    lineCoords[4].longitude = 110.295275;

    lineCoords[5].latitude = 25.266950;
    lineCoords[5].longitude = 110.295231;

    lineCoords[6].latitude = 25.267153;
    lineCoords[6].longitude = 110.295631;

    lineCoords[7].latitude = 25.267168;
    lineCoords[7].longitude = 110.295691;

    lineCoords[8].latitude = 25.267109;
    lineCoords[8].longitude = 110.295895;

    lineCoords[9].latitude = 25.267157;
    lineCoords[9].longitude = 110.296042;

    lineCoords[10].latitude = 25.267242;
    lineCoords[10].longitude = 110.296046;

    return lineCoords;

//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:11];
//    return polyLine;
}

//途经象眼岩
- (CLLocationCoordinate2D *)zxToTown_road2 {
    static CLLocationCoordinate2D lineCoords[15];

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266370;
    lineCoords[1].longitude = 110.295597;

    lineCoords[2].latitude = 25.266387;
    lineCoords[2].longitude = 110.296083;

    lineCoords[3].latitude = 25.266425;
    lineCoords[3].longitude = 110.296220;

    lineCoords[4].latitude = 25.266415;
    lineCoords[4].longitude = 110.296490;

    lineCoords[5].latitude = 25.266460;
    lineCoords[5].longitude = 110.296535;

    lineCoords[6].latitude = 25.266793;
    lineCoords[6].longitude = 110.296583;

    lineCoords[7].latitude = 25.267015;
    lineCoords[7].longitude = 110.296490;

    lineCoords[8].latitude = 25.267215;
    lineCoords[8].longitude = 110.296620;

    lineCoords[9].latitude = 25.267370;
    lineCoords[9].longitude = 110.296630;

    lineCoords[10].latitude = 25.267300;
    lineCoords[10].longitude = 110.296520;

    lineCoords[11].latitude = 25.267240;
    lineCoords[11].longitude = 110.296480;

    lineCoords[12].latitude = 25.267160;
    lineCoords[12].longitude = 110.296300;

    lineCoords[13].latitude = 25.267157;
    lineCoords[13].longitude = 110.296042;

    lineCoords[14].latitude = 25.267242;
    lineCoords[14].longitude = 110.296046;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:15];
//    return polyLine;
}

//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zxToTown_road3 {
    static CLLocationCoordinate2D lineCoords[11];

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266453;
    lineCoords[1].longitude = 110.295620;

    lineCoords[2].latitude = 25.266440;
    lineCoords[2].longitude = 110.295681;

    lineCoords[3].latitude = 25.266463;
    lineCoords[3].longitude = 110.295721;

    lineCoords[4].latitude = 25.266735;
    lineCoords[4].longitude = 110.295805;

    lineCoords[5].latitude = 25.266745;
    lineCoords[5].longitude = 110.295845;

    lineCoords[6].latitude = 25.266745;
    lineCoords[6].longitude = 110.296030;

    lineCoords[7].latitude = 25.266930;
    lineCoords[7].longitude = 110.296095;

    lineCoords[8].latitude = 25.267160;
    lineCoords[8].longitude = 110.296300;

    lineCoords[9].latitude = 25.267157;
    lineCoords[9].longitude = 110.296042;

    lineCoords[10].latitude = 25.267242;
    lineCoords[10].longitude = 110.296046;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:11];
//    return polyLine;
}

#pragma mark 醉乡-->象眼岩
//途经普贤塔
- (CLLocationCoordinate2D *)zxToRock_road1 {
    static CLLocationCoordinate2D lineCoords[13];

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266453;
    lineCoords[1].longitude = 110.295620;

    lineCoords[2].latitude = 25.266413;
    lineCoords[2].longitude = 110.295356;

    lineCoords[3].latitude = 25.266510;
    lineCoords[3].longitude = 110.295420;

    lineCoords[4].latitude = 25.266820;
    lineCoords[4].longitude = 110.295275;

    lineCoords[5].latitude = 25.266950;
    lineCoords[5].longitude = 110.295231;

    lineCoords[6].latitude = 25.267153;
    lineCoords[6].longitude = 110.295631;

    lineCoords[7].latitude = 25.267168;
    lineCoords[7].longitude = 110.295691;

    lineCoords[8].latitude = 25.267109;
    lineCoords[8].longitude = 110.295895;

    lineCoords[9].latitude = 25.267157;
    lineCoords[9].longitude = 110.296042;

    lineCoords[10].latitude = 25.267160;
    lineCoords[10].longitude = 110.296300;

    lineCoords[11].latitude = 25.267200;
    lineCoords[11].longitude = 110.296380;

    lineCoords[12].latitude = 25.267088;
    lineCoords[12].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:13];
//    return polyLine;
}

//途经象眼岩
- (CLLocationCoordinate2D *)zxToRock_road2 {
    static CLLocationCoordinate2D lineCoords[10];

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266370;
    lineCoords[1].longitude = 110.295597;

    lineCoords[2].latitude = 25.266387;
    lineCoords[2].longitude = 110.296083;

    lineCoords[3].latitude = 25.266425;
    lineCoords[3].longitude = 110.296220;

    lineCoords[4].latitude = 25.266415;
    lineCoords[4].longitude = 110.296490;

    lineCoords[5].latitude = 25.266460;
    lineCoords[5].longitude = 110.296535;

    lineCoords[6].latitude = 25.266793;
    lineCoords[6].longitude = 110.296583;

    lineCoords[7].latitude = 25.266935;
    lineCoords[7].longitude = 110.296500;

    lineCoords[8].latitude = 25.267015;
    lineCoords[8].longitude = 110.296490;

    lineCoords[9].latitude = 25.267088;
    lineCoords[9].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:10];
//    return polyLine;
}

//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zxToRock_road3 {
    static CLLocationCoordinate2D lineCoords[11];

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266453;
    lineCoords[1].longitude = 110.295620;

    lineCoords[2].latitude = 25.266440;
    lineCoords[2].longitude = 110.295681;

    lineCoords[3].latitude = 25.266463;
    lineCoords[3].longitude = 110.295721;

    lineCoords[4].latitude = 25.266735;
    lineCoords[4].longitude = 110.295805;

    lineCoords[5].latitude = 25.266745;
    lineCoords[5].longitude = 110.295845;

    lineCoords[6].latitude = 25.266745;
    lineCoords[6].longitude = 110.296030;

    lineCoords[7].latitude = 25.266930;
    lineCoords[7].longitude = 110.296095;

    lineCoords[8].latitude = 25.267160;
    lineCoords[8].longitude = 110.296300;

    lineCoords[9].latitude = 25.267200;
    lineCoords[9].longitude = 110.296380;

    lineCoords[10].latitude = 25.267088;
    lineCoords[10].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:11];
//    return polyLine;
}

#pragma mark 醉乡-->桂林抗战遗址
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zxToRuins_road {
    static CLLocationCoordinate2D lineCoords[8];

    //构建坐标
    lineCoords[0].latitude = 25.266416;
    lineCoords[0].longitude = 110.295621;

    lineCoords[1].latitude = 25.266453;
    lineCoords[1].longitude = 110.295620;

    lineCoords[2].latitude = 25.266440;
    lineCoords[2].longitude = 110.295681;

    lineCoords[3].latitude = 25.266463;
    lineCoords[3].longitude = 110.295721;

    lineCoords[4].latitude = 25.266735;
    lineCoords[4].longitude = 110.295805;

    lineCoords[5].latitude = 25.266745;
    lineCoords[5].longitude = 110.295845;

    lineCoords[6].latitude = 25.266745;
    lineCoords[6].longitude = 110.295960;

    lineCoords[7].latitude = 25.266798;
    lineCoords[7].longitude = 110.295988;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:8];
//    return polyLine;
}

#pragma mark 云峰寺-->普贤塔
//途经普贤塔
- (CLLocationCoordinate2D *)yfsToTown_road1 {
    static CLLocationCoordinate2D lineCoords[9];

    //构建坐标
    lineCoords[0].latitude = 25.266559;
    lineCoords[0].longitude = 110.295011;

    lineCoords[1].latitude = 25.266509;
    lineCoords[1].longitude = 110.295081;

    lineCoords[2].latitude = 25.266820;
    lineCoords[2].longitude = 110.295275;

    lineCoords[3].latitude = 25.266950;
    lineCoords[3].longitude = 110.295231;

    lineCoords[4].latitude = 25.267153;
    lineCoords[4].longitude = 110.295631;

    lineCoords[5].latitude = 25.267168;
    lineCoords[5].longitude = 110.295691;

    lineCoords[6].latitude = 25.267109;
    lineCoords[6].longitude = 110.295895;

    lineCoords[7].latitude = 25.267157;
    lineCoords[7].longitude = 110.296042;

    lineCoords[8].latitude = 25.267242;
    lineCoords[8].longitude = 110.296046;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:9];
//    return polyLine;
}

//途经桂林抗战遗址
- (CLLocationCoordinate2D *)yfsToTown_road2 {
    static CLLocationCoordinate2D lineCoords[14];

    //构建坐标
    lineCoords[0].latitude = 25.266559;
    lineCoords[0].longitude = 110.295011;

    lineCoords[1].latitude = 25.266620;
    lineCoords[1].longitude = 110.295031;

    lineCoords[2].latitude = 25.266565;
    lineCoords[2].longitude = 110.295145;

    lineCoords[3].latitude = 25.266400;
    lineCoords[3].longitude = 110.295371;

    lineCoords[4].latitude = 25.266453;
    lineCoords[4].longitude = 110.295620;

    lineCoords[5].latitude = 25.266440;
    lineCoords[5].longitude = 110.295681;

    lineCoords[6].latitude = 25.266463;
    lineCoords[6].longitude = 110.295721;

    lineCoords[7].latitude = 25.266735;
    lineCoords[7].longitude = 110.295805;

    lineCoords[8].latitude = 25.266745;
    lineCoords[8].longitude = 110.295845;

    lineCoords[9].latitude = 25.266745;
    lineCoords[9].longitude = 110.296030;

    lineCoords[10].latitude = 25.266930;
    lineCoords[10].longitude = 110.296095;

    lineCoords[11].latitude = 25.267160;
    lineCoords[11].longitude = 110.296300;

    lineCoords[12].latitude = 25.267157;
    lineCoords[12].longitude = 110.296042;

    lineCoords[13].latitude = 25.267242;
    lineCoords[13].longitude = 110.296046;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:14];
//    return polyLine;
}

#pragma mark 云峰寺-->象眼岩
//途经普贤塔
- (CLLocationCoordinate2D *)yfsToRock_road1 {
    static CLLocationCoordinate2D lineCoords[11];

    //构建坐标
    lineCoords[0].latitude = 25.266559;
    lineCoords[0].longitude = 110.295011;

    lineCoords[1].latitude = 25.266509;
    lineCoords[1].longitude = 110.295081;

    lineCoords[2].latitude = 25.266820;
    lineCoords[2].longitude = 110.295275;

    lineCoords[3].latitude = 25.266950;
    lineCoords[3].longitude = 110.295231;

    lineCoords[4].latitude = 25.267153;
    lineCoords[4].longitude = 110.295631;

    lineCoords[5].latitude = 25.267168;
    lineCoords[5].longitude = 110.295691;

    lineCoords[6].latitude = 25.267109;
    lineCoords[6].longitude = 110.295895;

    lineCoords[7].latitude = 25.267157;
    lineCoords[7].longitude = 110.296042;

    lineCoords[8].latitude = 25.267160;
    lineCoords[8].longitude = 110.296300;

    lineCoords[9].latitude = 25.267200;
    lineCoords[9].longitude = 110.296380;

    lineCoords[10].latitude = 25.267088;
    lineCoords[10].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:11];
//    return polyLine;
}

//途经象眼岩
- (CLLocationCoordinate2D *)yfsToRock_road2 {
    static CLLocationCoordinate2D lineCoords[14];

    //构建坐标
    lineCoords[0].latitude = 25.266559;
    lineCoords[0].longitude = 110.295011;

    lineCoords[1].latitude = 25.266620;
    lineCoords[1].longitude = 110.295031;

    lineCoords[2].latitude = 25.266565;
    lineCoords[2].longitude = 110.295145;

    lineCoords[3].latitude = 25.266400;
    lineCoords[3].longitude = 110.295371;

    lineCoords[4].latitude = 25.266365;
    lineCoords[4].longitude = 110.295481;

    lineCoords[5].latitude = 25.266370;
    lineCoords[5].longitude = 110.295597;

    lineCoords[6].latitude = 25.266387;
    lineCoords[6].longitude = 110.296083;

    lineCoords[7].latitude = 25.266425;
    lineCoords[7].longitude = 110.296220;

    lineCoords[8].latitude = 25.266415;
    lineCoords[8].longitude = 110.296490;

    lineCoords[9].latitude = 25.266460;
    lineCoords[9].longitude = 110.296535;

    lineCoords[10].latitude = 25.266793;
    lineCoords[10].longitude = 110.296583;

    lineCoords[11].latitude = 25.266935;
    lineCoords[11].longitude = 110.296500;

    lineCoords[12].latitude = 25.267015;
    lineCoords[12].longitude = 110.296490;

    lineCoords[13].latitude = 25.267088;
    lineCoords[13].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:14];
//    return polyLine;
}

//途经桂林抗战遗址
- (CLLocationCoordinate2D *)yfsToRock_road3 {
    static CLLocationCoordinate2D lineCoords[14];

    //构建坐标
    lineCoords[0].latitude = 25.266559;
    lineCoords[0].longitude = 110.295011;

    lineCoords[1].latitude = 25.266620;
    lineCoords[1].longitude = 110.295031;

    lineCoords[2].latitude = 25.266565;
    lineCoords[2].longitude = 110.295145;

    lineCoords[3].latitude = 25.266400;
    lineCoords[3].longitude = 110.295371;

    lineCoords[4].latitude = 25.266453;
    lineCoords[4].longitude = 110.295620;

    lineCoords[5].latitude = 25.266440;
    lineCoords[5].longitude = 110.295681;

    lineCoords[6].latitude = 25.266463;
    lineCoords[6].longitude = 110.295721;

    lineCoords[7].latitude = 25.266735;
    lineCoords[7].longitude = 110.295805;

    lineCoords[8].latitude = 25.266745;
    lineCoords[8].longitude = 110.295845;

    lineCoords[9].latitude = 25.266745;
    lineCoords[9].longitude = 110.296030;

    lineCoords[10].latitude = 25.266930;
    lineCoords[10].longitude = 110.296095;

    lineCoords[11].latitude = 25.267160;
    lineCoords[11].longitude = 110.296300;

    lineCoords[12].latitude = 25.267200;
    lineCoords[12].longitude = 110.296380;

    lineCoords[13].latitude = 25.267088;
    lineCoords[13].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:14];
//    return polyLine;
}

#pragma mark 云峰寺-->桂林抗战遗址
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)yfsToRuins_road {
    static CLLocationCoordinate2D lineCoords[11];

    //构建坐标
    lineCoords[0].latitude = 25.266559;
    lineCoords[0].longitude = 110.295011;

    lineCoords[1].latitude = 25.266620;
    lineCoords[1].longitude = 110.295031;

    lineCoords[2].latitude = 25.266565;
    lineCoords[2].longitude = 110.295145;

    lineCoords[3].latitude = 25.266400;
    lineCoords[3].longitude = 110.295371;

    lineCoords[4].latitude = 25.266453;
    lineCoords[4].longitude = 110.295620;

    lineCoords[5].latitude = 25.266440;
    lineCoords[5].longitude = 110.295681;

    lineCoords[6].latitude = 25.266463;
    lineCoords[6].longitude = 110.295721;

    lineCoords[7].latitude = 25.266735;
    lineCoords[7].longitude = 110.295805;

    lineCoords[8].latitude = 25.266745;
    lineCoords[8].longitude = 110.295845;

    lineCoords[9].latitude = 25.266745;
    lineCoords[9].longitude = 110.295960;

    lineCoords[10].latitude = 25.266798;
    lineCoords[10].longitude = 110.295988;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:11];
//    return polyLine;
}

#pragma mark 象山钟韵-->普贤塔
//途经普贤塔
- (CLLocationCoordinate2D *)zyToTown_road {
    static CLLocationCoordinate2D lineCoords[13];

    //构建坐标
    lineCoords[0].latitude = 25.267466;
    lineCoords[0].longitude = 110.295334;

    lineCoords[1].latitude = 25.267438;
    lineCoords[1].longitude = 110.295334;

    lineCoords[2].latitude = 25.267435;
    lineCoords[2].longitude = 110.295484;

    lineCoords[3].latitude = 25.267450;
    lineCoords[3].longitude = 110.295660;

    lineCoords[4].latitude = 25.267410;
    lineCoords[4].longitude = 110.295690;

    lineCoords[5].latitude = 25.267230;
    lineCoords[5].longitude = 110.295350;

    lineCoords[6].latitude = 25.267085;
    lineCoords[6].longitude = 110.295233;

    lineCoords[7].latitude = 25.266950;
    lineCoords[7].longitude = 110.295231;

    lineCoords[8].latitude = 25.267153;
    lineCoords[8].longitude = 110.295631;

    lineCoords[9].latitude = 25.267168;
    lineCoords[9].longitude = 110.295691;

    lineCoords[10].latitude = 25.267109;
    lineCoords[10].longitude = 110.295895;

    lineCoords[11].latitude = 25.267157;
    lineCoords[11].longitude = 110.296042;

    lineCoords[12].latitude = 25.267242;
    lineCoords[12].longitude = 110.296046;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:13];
//    return polyLine;
}

#pragma mark 象山钟韵-->象眼岩
//途经普贤塔
- (CLLocationCoordinate2D *)zyToRock_road1 {
    static CLLocationCoordinate2D lineCoords[15];

    //构建坐标
    lineCoords[0].latitude = 25.267466;
    lineCoords[0].longitude = 110.295334;

    lineCoords[1].latitude = 25.267438;
    lineCoords[1].longitude = 110.295334;

    lineCoords[2].latitude = 25.267435;
    lineCoords[2].longitude = 110.295484;

    lineCoords[3].latitude = 25.267450;
    lineCoords[3].longitude = 110.295660;

    lineCoords[4].latitude = 25.267410;
    lineCoords[4].longitude = 110.295690;

    lineCoords[5].latitude = 25.267230;
    lineCoords[5].longitude = 110.295350;

    lineCoords[6].latitude = 25.267085;
    lineCoords[6].longitude = 110.295233;

    lineCoords[7].latitude = 25.266950;
    lineCoords[7].longitude = 110.295231;

    lineCoords[8].latitude = 25.267153;
    lineCoords[8].longitude = 110.295631;

    lineCoords[9].latitude = 25.267168;
    lineCoords[9].longitude = 110.295691;

    lineCoords[10].latitude = 25.267109;
    lineCoords[10].longitude = 110.295895;

    lineCoords[11].latitude = 25.267157;
    lineCoords[11].longitude = 110.296042;

    lineCoords[12].latitude = 25.267160;
    lineCoords[12].longitude = 110.296300;

    lineCoords[13].latitude = 25.267200;
    lineCoords[13].longitude = 110.296380;

    lineCoords[14].latitude = 25.267088;
    lineCoords[14].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:15];
//    return polyLine;
}

//途经象眼岩
- (CLLocationCoordinate2D *)zyToRock_road2 {
    static CLLocationCoordinate2D lineCoords[21];

    //构建坐标
    lineCoords[0].latitude = 25.267466;
    lineCoords[0].longitude = 110.295334;

    lineCoords[1].latitude = 25.267438;
    lineCoords[1].longitude = 110.295334;

    lineCoords[2].latitude = 25.267435;
    lineCoords[2].longitude = 110.295484;

    lineCoords[3].latitude = 25.267450;
    lineCoords[3].longitude = 110.295660;

    lineCoords[4].latitude = 25.267410;
    lineCoords[4].longitude = 110.295690;

    lineCoords[5].latitude = 25.267230;
    lineCoords[5].longitude = 110.295350;

    lineCoords[6].latitude = 25.267085;
    lineCoords[6].longitude = 110.295233;

    lineCoords[7].latitude = 25.266950;
    lineCoords[7].longitude = 110.295231;

    lineCoords[8].latitude = 25.266820;
    lineCoords[8].longitude = 110.295275;

    lineCoords[9].latitude = 25.266510;
    lineCoords[9].longitude = 110.295420;

    lineCoords[10].latitude = 25.266413;
    lineCoords[10].longitude = 110.295356;

    lineCoords[11].latitude = 25.266365;
    lineCoords[11].longitude = 110.295481;

    lineCoords[12].latitude = 25.266370;
    lineCoords[12].longitude = 110.295597;

    lineCoords[13].latitude = 25.266387;
    lineCoords[13].longitude = 110.296083;

    lineCoords[14].latitude = 25.266425;
    lineCoords[14].longitude = 110.296220;

    lineCoords[15].latitude = 25.266415;
    lineCoords[15].longitude = 110.296490;

    lineCoords[16].latitude = 25.266460;
    lineCoords[16].longitude = 110.296535;

    lineCoords[17].latitude = 25.266793;
    lineCoords[17].longitude = 110.296583;

    lineCoords[18].latitude = 25.266935;
    lineCoords[18].longitude = 110.296500;

    lineCoords[19].latitude = 25.267015;
    lineCoords[19].longitude = 110.296490;

    lineCoords[20].latitude = 25.267088;
    lineCoords[20].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:21];
//    return polyLine;
}

//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zyToRock_road3 {
    static CLLocationCoordinate2D lineCoords[21];

    //构建坐标
    lineCoords[0].latitude = 25.267466;
    lineCoords[0].longitude = 110.295334;

    lineCoords[1].latitude = 25.267438;
    lineCoords[1].longitude = 110.295334;

    lineCoords[2].latitude = 25.267435;
    lineCoords[2].longitude = 110.295484;

    lineCoords[3].latitude = 25.267450;
    lineCoords[3].longitude = 110.295660;

    lineCoords[4].latitude = 25.267410;
    lineCoords[4].longitude = 110.295690;

    lineCoords[5].latitude = 25.267230;
    lineCoords[5].longitude = 110.295350;

    lineCoords[6].latitude = 25.267085;
    lineCoords[6].longitude = 110.295233;

    lineCoords[7].latitude = 25.266950;
    lineCoords[7].longitude = 110.295231;

    lineCoords[8].latitude = 25.266820;
    lineCoords[8].longitude = 110.295275;

    lineCoords[9].latitude = 25.266510;
    lineCoords[9].longitude = 110.295420;

    lineCoords[10].latitude = 25.266413;
    lineCoords[10].longitude = 110.295356;

    lineCoords[11].latitude = 25.266453;
    lineCoords[11].longitude = 110.295620;

    lineCoords[12].latitude = 25.266440;
    lineCoords[12].longitude = 110.295681;

    lineCoords[13].latitude = 25.266463;
    lineCoords[13].longitude = 110.295721;

    lineCoords[14].latitude = 25.266735;
    lineCoords[14].longitude = 110.295805;

    lineCoords[15].latitude = 25.266745;
    lineCoords[15].longitude = 110.295845;

    lineCoords[16].latitude = 25.266745;
    lineCoords[16].longitude = 110.296030;

    lineCoords[17].latitude = 25.266930;
    lineCoords[17].longitude = 110.296095;

    lineCoords[18].latitude = 25.267160;
    lineCoords[18].longitude = 110.296300;

    lineCoords[19].latitude = 25.267200;
    lineCoords[19].longitude = 110.296380;

    lineCoords[20].latitude = 25.267088;
    lineCoords[20].longitude = 110.296427;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:21];
//    return polyLine;
}

#pragma mark 象山钟韵-->桂林抗战遗址
//途经普贤塔
- (CLLocationCoordinate2D *)zyToRuins_road1 {
    static CLLocationCoordinate2D lineCoords[17];

    //构建坐标
    lineCoords[0].latitude = 25.267466;
    lineCoords[0].longitude = 110.295334;

    lineCoords[1].latitude = 25.267438;
    lineCoords[1].longitude = 110.295334;

    lineCoords[2].latitude = 25.267435;
    lineCoords[2].longitude = 110.295484;

    lineCoords[3].latitude = 25.267450;
    lineCoords[3].longitude = 110.295660;

    lineCoords[4].latitude = 25.267410;
    lineCoords[4].longitude = 110.295690;

    lineCoords[5].latitude = 25.267230;
    lineCoords[5].longitude = 110.295350;

    lineCoords[6].latitude = 25.267085;
    lineCoords[6].longitude = 110.295233;

    lineCoords[7].latitude = 25.266950;
    lineCoords[7].longitude = 110.295231;

    lineCoords[8].latitude = 25.267153;
    lineCoords[8].longitude = 110.295631;

    lineCoords[9].latitude = 25.267168;
    lineCoords[9].longitude = 110.295691;

    lineCoords[10].latitude = 25.267109;
    lineCoords[10].longitude = 110.295895;

    lineCoords[11].latitude = 25.267157;
    lineCoords[11].longitude = 110.296042;

    lineCoords[12].latitude = 25.267160;
    lineCoords[12].longitude = 110.296300;

    lineCoords[13].latitude = 25.266930;
    lineCoords[13].longitude = 110.296095;

    lineCoords[14].latitude = 25.266745;
    lineCoords[14].longitude = 110.296030;

    lineCoords[15].latitude = 25.266745;
    lineCoords[15].longitude = 110.295980;

    lineCoords[16].latitude = 25.266798;
    lineCoords[16].longitude = 110.295988;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:17];
//    return polyLine;
}

//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zyToRuins_road2 {
    static CLLocationCoordinate2D lineCoords[18];

    //构建坐标
    lineCoords[0].latitude = 25.267466;
    lineCoords[0].longitude = 110.295334;

    lineCoords[1].latitude = 25.267438;
    lineCoords[1].longitude = 110.295334;

    lineCoords[2].latitude = 25.267435;
    lineCoords[2].longitude = 110.295484;

    lineCoords[3].latitude = 25.267450;
    lineCoords[3].longitude = 110.295660;

    lineCoords[4].latitude = 25.267410;
    lineCoords[4].longitude = 110.295690;

    lineCoords[5].latitude = 25.267230;
    lineCoords[5].longitude = 110.295350;

    lineCoords[6].latitude = 25.267085;
    lineCoords[6].longitude = 110.295233;

    lineCoords[7].latitude = 25.266950;
    lineCoords[7].longitude = 110.295231;

    lineCoords[8].latitude = 25.266820;
    lineCoords[8].longitude = 110.295275;

    lineCoords[9].latitude = 25.266510;
    lineCoords[9].longitude = 110.295420;

    lineCoords[10].latitude = 25.266413;
    lineCoords[10].longitude = 110.295356;

    lineCoords[11].latitude = 25.266453;
    lineCoords[11].longitude = 110.295620;

    lineCoords[12].latitude = 25.266440;
    lineCoords[12].longitude = 110.295681;

    lineCoords[13].latitude = 25.266463;
    lineCoords[13].longitude = 110.295721;

    lineCoords[14].latitude = 25.266735;
    lineCoords[14].longitude = 110.295805;

    lineCoords[15].latitude = 25.266745;
    lineCoords[15].longitude = 110.295845;

    lineCoords[16].latitude = 25.266745;
    lineCoords[16].longitude = 110.295980;

    lineCoords[17].latitude = 25.266798;
    lineCoords[17].longitude = 110.295988;

    return lineCoords;
    
//    //通过坐标得到线路
//    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:lineCoords count:18];
//    return polyLine;
}

@end
