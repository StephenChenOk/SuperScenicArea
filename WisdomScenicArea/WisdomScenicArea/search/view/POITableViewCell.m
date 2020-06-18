//
//  POITableViewCell.m
//  WisdomScenicArea
//
//  Created by chen on 2020/6/17.
//

#import "POITableViewCell.h"
#import "ScreenUtil.h"
#import "PoiItem.h"


@interface POITableViewCell()

@property(nonatomic,strong,readwrite)UILabel *name;
@property(nonatomic,strong,readwrite)UILabel *address;

@end

@implementation POITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        [self.contentView addSubview:({
            UIImageView *logo = [[UIImageView alloc] initWithFrame:UIRect(20, 25, 20, 20)];
            logo.image = [UIImage imageNamed:@"search_pressed"];
            logo;
        })];
        [self.contentView addSubview:({
            _name = [[UILabel alloc] initWithFrame:UIRect(59, 15, 290, 21)];
            _name.font = [UIFont systemFontOfSize:UI(16)];
            _name;
        })];
        [self.contentView addSubview:({
            _address = [[UILabel alloc] initWithFrame:UIRect(59, 37, 290, 21)];
            _address.font = [UIFont systemFontOfSize:UI(14)];
            _address.textColor = [UIColor darkGrayColor];
            _address;
        })];
        [self.contentView addSubview:({
            UIImageView *enter = [[UIImageView alloc] initWithFrame:UIRect(369, 25, 20, 20)];
            enter.image = [UIImage imageNamed:@"goto_20"];
            enter;
        })];
        
    }
    
    return self;
}

- (void)setDataInCellWithItem:(PoiItem *) item andIndex:(NSInteger)index{
    self.name.text = item.name;
    self.address.text = item.address;
}

@end
