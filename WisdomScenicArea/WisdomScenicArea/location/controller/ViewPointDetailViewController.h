//
//  ViewPointDetailViewController.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewPointItem;

NS_ASSUME_NONNULL_BEGIN

@interface ViewPointDetailViewController : UIViewController

- (void)initDetailData:(ViewPointItem *)item;

@end

NS_ASSUME_NONNULL_END
