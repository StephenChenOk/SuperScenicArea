//
//  UIColor+TransformColor.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/20.
//  Copyright © 2020 chen. All rights reserved.
//

#import "UIColor+TransformColor.h"

@implementation UIColor(TransformColor)

     //16进制颜色转换为UIColor
     //@param hexColor 16进制字符串（可以以0x开头，可以以#开头，也可以就是6位的16进制）
     //@param opacity 透明度
     //@return 16进制字符串对应的颜色
    +(UIColor *)colorWithHexString:(NSString *)hexColor alpha:(float)opacity{
        NSString * cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

        // String should be 6 or 8 characters
        if ([cString length] < 6) return [UIColor blackColor];

        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];

        if ([cString length] != 6) return [UIColor blackColor];

        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString * rString = [cString substringWithRange:range];

        range.location = 2;
        NSString * gString = [cString substringWithRange:range];

        range.location = 4;
        NSString * bString = [cString substringWithRange:range];

        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];

        return [UIColor colorWithRed:((float)r / 255.0f)
                               green:((float)g / 255.0f)
                                blue:((float)b / 255.0f)
                               alpha:opacity];
    }

    //16进制数值转化为UIClor
    +(UIColor*)colorWithRGB:(NSUInteger)hex lpha:(CGFloat)alpha
    {
        float r, g, b, a;
        a = alpha;
        b = hex & 0x0000FF;
        hex = hex >> 8;
        g = hex & 0x0000FF;
        hex = hex >> 8;
        r = hex;

        return [UIColor colorWithRed:r/255.0f
                               green:g/255.0f
                               blue:b/255.0f
                               alpha:a];
    }

@end