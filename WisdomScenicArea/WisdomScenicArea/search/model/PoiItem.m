//
//  PoiItem.m
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import "PoiItem.h"

@implementation PoiItem

- (instancetype)initWithName:(NSString *)name andAddress:(NSString *)address andLatitude:(double)latitude andLongitude:(double)longitude {
    self = [super init];
    self.name = name;
    self.address = address;
    self.latitude = latitude;
    self.longitude = longitude;
    return self;
}

@end
