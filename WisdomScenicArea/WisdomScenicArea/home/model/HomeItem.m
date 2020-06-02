//
//  HomeItem.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import "HomeItem.h"

@implementation HomeItem

- (void) setImgUrl:(NSString *)imgUrl setName:(NSString *)name Address:(NSString *)address Views:(NSString *)views Distance:(NSString *)distance{
    _imgUrl = imgUrl;
    _name = name;
    _address = address;
    _views = views;
    _distance = distance;
}

@end
