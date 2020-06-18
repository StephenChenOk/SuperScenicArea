//
//  QFTextField.m
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import "QFTextField.h"
#import "ScreenUtil.h"

//TextField设置内边距
@implementation QFTextField

// 左图片与TextField边框的距离
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += UI(10); //像右边偏15
    return iconRect;
}

//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{

    return CGRectInset(bounds, UI(35), 0);

}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    

    return CGRectInset(bounds, UI(35), 0);
}


@end
