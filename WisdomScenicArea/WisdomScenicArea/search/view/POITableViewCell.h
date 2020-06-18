//
//  POITableViewCell.h
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import <UIKit/UIKit.h>
@class PoiItem;

NS_ASSUME_NONNULL_BEGIN

@interface POITableViewCell : UITableViewCell

- (void)setDataInCellWithItem:(PoiItem *)item andIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
