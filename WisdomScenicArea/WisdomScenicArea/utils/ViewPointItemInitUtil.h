//
//  ViewPointItemInitUtil.h
//  WisdomScenicArea
//
//  Created by chen on 2020/5/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPointItemInitUtil : NSObject

//初始化重庆景点数据
+ (NSArray *)getChongqingData;
//初始化上海景点数据
+ (NSArray *)getShanghaiData;

@end

NS_ASSUME_NONNULL_END
