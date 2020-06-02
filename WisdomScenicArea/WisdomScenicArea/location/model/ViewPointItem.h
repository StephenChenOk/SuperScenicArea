//
//  ViewPointItem.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewPointItem : NSObject

@property (nonatomic,copy,readwrite) NSString *imgUrl;

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, copy, readwrite) NSString *address;

@property (nonatomic, copy, readwrite) NSString *scoreText;
@property (nonatomic, copy, readwrite) NSString *distanceText;

@property (nonatomic,readwrite)double latitude;
@property (nonatomic,readwrite)double longitude;

@property (nonatomic, copy, readwrite) NSString *detailInfo;

- (void) setImgUrl:(NSString *)imgUrl setName:(NSString *)name address:(NSString *)address scoreText:(NSString *)scoreText distanceText:(NSString *)distanceText detailInfo:(NSString *)detailInfo;

@end

NS_ASSUME_NONNULL_END
