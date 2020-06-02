//
//  BannerView.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BannerView;

NS_ASSUME_NONNULL_BEGIN

@protocol BannerViewDelegate <NSObject>
//判断点击的那个
- (void)sendImageName:(BannerView *)BannerView andName:(NSInteger)selectImage;
@end

@interface BannerView : UIView
@property (nonatomic, weak) id <BannerViewDelegate>delegate;
//传一个frame 和 装有图片名字的数组过来
//参数一：frame
//参数二：装有图片名字的数组
//参数三：BOOL如果是YES，那么自动滚动，如果是NO不滚动
- (id)                              initWithFrame:(CGRect)frame andImageNameArray:
    (NSMutableArray *)imageNameArray andIsRunning:(BOOL)isRunning;
@end

NS_ASSUME_NONNULL_END
