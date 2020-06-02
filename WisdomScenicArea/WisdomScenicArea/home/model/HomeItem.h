//
//  HomeItem.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeItem : NSObject

@property (nonatomic,copy,readwrite) NSString *imgUrl;

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *address;

@property (nonatomic, copy, readwrite) NSString *views;
@property (nonatomic, copy, readwrite) NSString *distance;

@property (nonatomic,readwrite) double latitude;
@property (nonatomic,readwrite) double logitude;

- (void) setImgUrl:(NSString *)imgUrl setName:(NSString *)name Address:(NSString *)address Views:(NSString *)views Distance:(NSString *)distance;

@end

NS_ASSUME_NONNULL_END
