//
//  HomeItemTableViewCell.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/25.
//  Copyright © 2020 chen. All rights reserved.
//

#import "HomeItemTableViewCell.h"
#import "HomeItem.h"
#import "ScreenUtil.h"

@interface HomeItemTableViewCell ()

@property (nonatomic, strong, readwrite) UIImageView *img;
@property (nonatomic, strong, readwrite) UILabel *name;
@property (nonatomic, strong, readwrite) UILabel *address;
@property (nonatomic, strong, readwrite) UILabel *views;
@property (nonatomic, strong, readwrite) UILabel *distance;

@end

@implementation HomeItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:({
            self.img = [[UIImageView alloc] initWithFrame:UIRect(14, 16, 120, 80)];
            self.img.contentMode = UIViewContentModeScaleAspectFit;
            self.img.layer.cornerRadius = UI(5);
            self.img.layer.masksToBounds = YES;
            self.img;
        })];

        [self.contentView addSubview:({
            self.name = [[UILabel alloc] initWithFrame:UIRect(149, 16, 190, 20)];
            self.name.font = [UIFont systemFontOfSize:15];
            self.name.textColor = [UIColor blackColor];
            self.name.lineBreakMode = NSLineBreakByTruncatingTail; //太长时在尾巴处截断
            self.name;
        })];

        [self.contentView addSubview:({
            self.address = [[UILabel alloc] initWithFrame:UIRect(149, 39, 190, 18)];
            self.address.font = [UIFont systemFontOfSize:14];
            self.address.textColor = [UIColor darkGrayColor];
            self.address.numberOfLines = 2;
            self.address.lineBreakMode = NSLineBreakByTruncatingTail; //太长时在尾巴处截断
            self.address;
        })];

        [self.contentView addSubview:({
            UIImageView *scoreImg = [[UIImageView alloc] initWithFrame:UIRect(148, 75, 20, 20)];
            scoreImg.contentMode = UIViewContentModeScaleAspectFit;
            [scoreImg setImage:[UIImage imageNamed:@"click_number_logo"]];
            scoreImg;
        })];

        [self.contentView addSubview:({
            self.views = [[UILabel alloc] initWithFrame:UIRect(174, 78, 66, 15)];
            self.views.font = [UIFont systemFontOfSize:UI(13)];
            self.views.textColor = [UIColor grayColor];
            self.views.lineBreakMode = NSLineBreakByTruncatingTail;     //太长时在尾巴处截断
            self.views;
        })];

        [self.contentView addSubview:({
            self.distance = [[UILabel alloc] initWithFrame:UIRect(325, 78, 65, 15)];
            self.distance.font = [UIFont systemFontOfSize:UI(13)];
            self.distance.textColor = [UIColor grayColor];
            self.distance.lineBreakMode = NSLineBreakByTruncatingTail;   //太长时在尾巴处截断
            self.distance;
        })];
    }
    return self;
}

- (void)setDataInCellWithItem:(HomeItem *)item {
    [self.img setImage:[UIImage imageNamed:item.imgUrl]];
    self.name.text = item.name;
    self.address.text = item.address;
    self.views.text = item.views;
    self.distance.text = item.distance;
}

@end
