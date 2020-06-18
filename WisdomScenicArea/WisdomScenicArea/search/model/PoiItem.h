//
//  PoiItem.h
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import <Foundation/Foundation.h>
@class PoiItem;

NS_ASSUME_NONNULL_BEGIN

@interface PoiItem : NSObject

@property(nonatomic,strong,readwrite)NSString *name;
@property(nonatomic,strong,readwrite)NSString *address;
@property(nonatomic,readwrite)double latitude;
@property(nonatomic,readwrite)double longitude;

- (instancetype)initWithName:(NSString*)name andAddress:(NSString*)address andLatitude:(double)latitude andLongitude:(double)longitude;

@end

NS_ASSUME_NONNULL_END
