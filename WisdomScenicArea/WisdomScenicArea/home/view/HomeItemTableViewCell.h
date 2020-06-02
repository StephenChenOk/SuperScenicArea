//
//  HomeItemTableViewCell.h
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeItem;

NS_ASSUME_NONNULL_BEGIN

@interface HomeItemTableViewCell : UITableViewCell
-(void) setDataInCellWithItem:(HomeItem *) item;
@end

NS_ASSUME_NONNULL_END
