//
//  ViewPointTableViewCell.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewPointItem;

NS_ASSUME_NONNULL_BEGIN

@protocol DetailDelegate <NSObject>

@required   //一定要实现
- (void)gotoDetailPageWithIndex:(NSInteger)index;

@optional  //可以选择实现

@end

@interface ViewPointTableViewCell : UITableViewCell

@property (nonatomic , strong ,readwrite) id<DetailDelegate> delegate;

-(void) setDataInCellWithItem:(ViewPointItem *) item andIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
