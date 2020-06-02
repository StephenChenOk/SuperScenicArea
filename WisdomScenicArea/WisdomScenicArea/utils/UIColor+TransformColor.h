//
//  UIColor+TransformColor.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/20.
//  Copyright © 2020 chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIColor(TransformColor)

+(UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity;
+(UIColor*)colorWithRGB:(NSUInteger)hex lpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
