//
//  QFLabelView.m
//  WisdomScenicArea
//
//  Created by chen on 2020/5/31.
//

#import "QFLabelView.h"

//自定义label view
//1 可以实现在左上角开始显示
//2 可以实现内边距
@interface QFLabelView()

@end

@implementation QFLabelView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

//修改绘制文字的区域
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    textRect.origin.y = bounds.origin.y;
    
    return textRect;
    
}

//绘制文字
-(void)drawTextInRect:(CGRect)requestedRect {
    
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    
    [super drawTextInRect:actualRect];
}

@end
