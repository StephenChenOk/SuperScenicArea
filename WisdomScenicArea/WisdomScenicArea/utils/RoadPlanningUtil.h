//
//  RoadPlanningUtil.h
//  WisdomScenicArea
//
//  Created by chen on 2020/5/29.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoadPlanningUtil : NSObject

#pragma mark 醉乡-->普贤塔
//途经普贤塔
- (CLLocationCoordinate2D *)zxToTown_road1;  //ok
//途经象眼岩
- (CLLocationCoordinate2D *)zxToTown_road2;  //ok
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zxToTown_road3;  //ok

#pragma mark 醉乡-->象眼岩
//途经普贤塔
- (CLLocationCoordinate2D *)zxToRock_road1;  //ok
//途经象眼岩
- (CLLocationCoordinate2D *)zxToRock_road2;  //ok
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zxToRock_road3;  //ok

#pragma mark 醉乡-->桂林抗战遗址
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zxToRuins_road;  //no

#pragma mark 云峰寺-->普贤塔
//途经普贤塔
- (CLLocationCoordinate2D *)yfsToTown_road1;  //ok
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)yfsToTown_road2;  //ok

#pragma mark 云峰寺-->象眼岩
//途经普贤塔
- (CLLocationCoordinate2D *)yfsToRock_road1;  //ok
//途经象眼岩
- (CLLocationCoordinate2D *)yfsToRock_road2;  //ok
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)yfsToRock_road3;  //ok

#pragma mark 云峰寺-->桂林抗战遗址
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)yfsToRuins_road;  //ok

#pragma mark 象山钟韵-->普贤塔
//途经普贤塔
- (CLLocationCoordinate2D *)zyToTown_road;  //ok

#pragma mark 象山钟韵-->象眼岩
//途经普贤塔
- (CLLocationCoordinate2D *)zyToRock_road1;  //ok
//途经象眼岩
- (CLLocationCoordinate2D *)zyToRock_road2;  //ok
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zyToRock_road3;  //ok

#pragma mark 象山钟韵-->桂林抗战遗址
//途经普贤塔
- (CLLocationCoordinate2D *)zyToRuins_road1;  //ok
//途经桂林抗战遗址
- (CLLocationCoordinate2D *)zyToRuins_road2;

@end

NS_ASSUME_NONNULL_END
