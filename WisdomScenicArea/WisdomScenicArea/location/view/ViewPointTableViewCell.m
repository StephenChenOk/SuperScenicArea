//
//  ViewPointTableViewCell.m
//  SmartScenicArea
//
//  Created by chen on 2020/5/24.
//  Copyright © 2020 chen. All rights reserved.
//

#import "ViewPointTableViewCell.h"
#import "ViewPointItem.h"

@interface ViewPointTableViewCell ()

@property (nonatomic, strong, readwrite) UIImageView *img;
@property (nonatomic, strong, readwrite) UILabel *name;
@property (nonatomic, strong, readwrite) UILabel *address;
@property (nonatomic, strong, readwrite) UILabel *scoreLable;
@property (nonatomic, strong, readwrite) UILabel *distanceLable;

@property (nonatomic,strong ,readwrite) UIView *detailBox;

@property (nonatomic,readwrite) NSInteger index;

@end

@implementation ViewPointTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:({
            self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 120, 80)];
            self.img.contentMode = UIViewContentModeScaleAspectFit;
            self.img.layer.cornerRadius = 5;
            self.img.layer.masksToBounds = YES;
            self.img;
        })];

        [self.contentView addSubview:({
            self.name = [[UILabel alloc] initWithFrame:CGRectMake(150, 11, 220, 20)];
            self.name.font = [UIFont systemFontOfSize:15];
            self.name.textColor = [UIColor blackColor];
            self.name.lineBreakMode = NSLineBreakByTruncatingTail;  //太长时在尾巴处截断
            self.name;
        })];

        [self.contentView addSubview:({
            self.address = [[UILabel alloc] initWithFrame:CGRectMake(150, 37, 220, 18)];
            self.address.font = [UIFont systemFontOfSize:14];
            self.address.textColor = [UIColor darkGrayColor];
            self.address.numberOfLines = 2;
            self.address.lineBreakMode = NSLineBreakByTruncatingTail;  //太长时在尾巴处截断
            self.address;
        })];

        [self.contentView addSubview:({
            UIImageView *scoreImg = [[UIImageView alloc] initWithFrame:CGRectMake(150, 67, 20, 20)];
            scoreImg.contentMode = UIViewContentModeScaleAspectFit;
            [scoreImg setImage:[UIImage imageNamed:@"score_viewpoint"]];
            scoreImg;
        })];

        [self.contentView addSubview:({
            self.scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(178, 68, 60, 15)];
            self.scoreLable.font = [UIFont systemFontOfSize:13];
            self.scoreLable.textColor = [UIColor grayColor];
            self.scoreLable.lineBreakMode = NSLineBreakByTruncatingTail;         //太长时在尾巴处截断
            self.scoreLable;
        })];

        [self.contentView addSubview:({
            UIImageView *distanceImg = [[UIImageView alloc] initWithFrame:CGRectMake(150, 92, 20, 20)];
            distanceImg.contentMode = UIViewContentModeScaleAspectFit;
            [distanceImg setImage:[UIImage imageNamed:@"distance_viewpoint"]];
            distanceImg;
        })];

        [self.contentView addSubview:({
            self.distanceLable = [[UILabel alloc] initWithFrame:CGRectMake(178, 94, 100, 15)];
            self.distanceLable.font = [UIFont systemFontOfSize:13];
            self.distanceLable.textColor = [UIColor grayColor];
            self.distanceLable.lineBreakMode = NSLineBreakByTruncatingTail;       //太长时在尾巴处截断
            self.distanceLable;
        })];
        
        [self.contentView addSubview:({
            self.detailBox = [[UIView alloc] initWithFrame:CGRectMake(356, 64, 50, 50)];
            
            [self.detailBox addSubview:({
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(21, 10, 27, 16)];
                label.font = [UIFont systemFontOfSize:13];
                label.textColor = [UIColor grayColor];
                label.text = @"详情";
                label;
            })];
            [self.detailBox addSubview:({
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(22, 21, 24, 24)];
                image.image = [UIImage imageNamed:@"detail"];
                image;
            })];
            
            UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoDetailPageWithIndex)];
            [self.detailBox addGestureRecognizer:gestureRecognizer];
            
            self.detailBox;
        })];
    }
    return self;
}

- (void)setDataInCellWithItem:(ViewPointItem *) item andIndex:(NSInteger)index{
    [self.img setImage:[UIImage imageNamed:item.imgUrl]];
    self.name.text = item.name;
    self.address.text = item.address;
    self.scoreLable.text = item.scoreText;
    self.distanceLable.text = item.distanceText;
    
    //记录当前cell是第几个
    self.index = index;
}

#pragma mark --跳转详情界面
- (void)gotoDetailPageWithIndex{
    [_delegate gotoDetailPageWithIndex:self.index];
}

@end
