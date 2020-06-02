//
//  MapViewController.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController

- (void)setLatitude:(double)latitude andLongitude:(double)longitude isFirstEnter:(BOOL)isFirst;

@end

NS_ASSUME_NONNULL_END
