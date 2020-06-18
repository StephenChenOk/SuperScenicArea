//
//  ScreenUtil.h
//  WisdomScenicArea
//
//  Created by chen on 2020/6/5.
//

#import <UIKit/UIKit.h>

//屏幕适配工具类

NS_ASSUME_NONNULL_BEGIN

//判断是横屏还是竖屏
//#define IS_LANDSCAPE       (UIInterfaceOrientationIsLandscape([[[[[UIApplication sharedApplication] windows] firstObject] windowScene] interfaceOrientation]))
#define IS_LANDSCAPE (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

//屏幕宽度/高度
#define SCREEN_WIDTH       (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.height : [[UIScreen mainScreen ] bounds].size.width)
#define SCREEN_HEIGHT      (IS_LANDSCAPE ? [[UIScreen mainScreen ] bounds].size.width : [[UIScreen mainScreen ] bounds].size.height)

//判断是否是iphonex/xr/max（都有刘海屏）
#define IS_IPHONE_X_XR_MAX (IS_IPHONE_X || IS_IPHONE_XR || IS_IPHONE_XMAX)
//iphone x
#define IS_IPHONE_X        (SCREEN_WIDTH == [ScreenUtil sizeFor58Inch].width && SCREEN_HEIGHT == [ScreenUtil sizeFor58Inch].height)
//iphone xr
#define IS_IPHONE_XR       (SCREEN_WIDTH == [ScreenUtil sizeFor61Inch].width && SCREEN_HEIGHT == [ScreenUtil sizeFor61Inch].height && [UIScreen mainScreen].scale == 2)
//iphone max
#define IS_IPHONE_XMAX     (SCREEN_WIDTH == [ScreenUtil sizeFor65Inch].width && SCREEN_HEIGHT == [ScreenUtil sizeFor65Inch].height && [UIScreen mainScreen].scale == 3)

//屏幕顶部大小
#define STATUSBAR_HEIGHT    (IS_IPHONE_X_XR_MAX ? 44 : 20)

//根据机型适配大小
#define UI(x)                       UIAdapter(x)
#define UIRect(x, y, width, height) UIRectAdapter(x, y, width, height)
#define UIPoint(x, y)               UIPointAdapter(x, y)
#define UISize(x, y)                UISizeAdapter(x, y)

//内敛函数，类似于宏定义，在使用处直接进行替换展开，效率很高，可以解决一些频繁调用的函数大量消耗栈空间的问题
static inline NSInteger UIAdapter(float x)
{
    //1 - 分机型 特定的比例

    //2 - 屏幕宽度按比例适配
    CGFloat scale = 414 / SCREEN_WIDTH;
    return (NSInteger)x / scale;
}

//...完善其他方法..size..rect..origin..
static inline CGRect UIRectAdapter(x, y, width, height)
{
    return CGRectMake(UIAdapter(x), UIAdapter(y), UIAdapter(width), UIAdapter(height));
}

static inline CGPoint UIPointAdapter(x, y)
{
    return CGPointMake(UIAdapter(x), UIAdapter(y));
}

static inline CGSize UISizeAdapter(width, height)
{
    return CGSizeMake(UIAdapter(width), UIAdapter(height));
}

@interface ScreenUtil : NSObject

//iphone xs max
+ (CGSize)sizeFor65Inch;

//iphone xr
+ (CGSize)sizeFor61Inch;

// iphonex
+ (CGSize)sizeFor58Inch;

//...其它机型

@end

NS_ASSUME_NONNULL_END
