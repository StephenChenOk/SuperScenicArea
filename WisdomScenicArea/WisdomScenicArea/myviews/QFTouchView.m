//
//  QFTouchView.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/27.
//

#import "QFTouchView.h"
#import "UIColor+TransformColor.h"

//实现按下view后改变颜色，离开后恢复颜色

@implementation QFTouchView

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.backgroundColor = [UIColor colorWithRGB:0xF8F7F7 lpha:1];
}

@end
