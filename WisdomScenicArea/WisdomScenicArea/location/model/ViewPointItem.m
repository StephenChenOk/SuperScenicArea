//
//  ViewPointItem.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import "ViewPointItem.h"

@interface ViewPointItem ()

@end

@implementation ViewPointItem

- (void)setImgUrl:(NSString *)imgUrl setName:(NSString *)name address:(NSString *)address scoreText:(NSString *)scoreText distanceText:(NSString *)distanceText detailInfo:(NSString *)detailInfo{
    _imgUrl = imgUrl;
    _name = name;
    _address = address;
    _scoreText = scoreText;
    _distanceText = distanceText;
    _detailInfo = detailInfo;
}

@end
