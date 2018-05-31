//
//  FSHomeCollectionViewCell.m
//  TrendyhomeAcademy
//
//  Created by Fashion+ on 2018/4/24.
//  Copyright © 2018年 Fashion+. All rights reserved.
//

#import "FSHomeCollectionViewCell.h"

@interface FSHomeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *subHeadCount;

@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;


@end


@implementation FSHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    FSViewBorderRadius(self, 8, 1, [UIColor lightGrayColor]);
}

- (void)setModel:(FSMovieModel *)model {
    _model = model;
    DLog(@"imageURL=%@", _model.iconaddress);
    [FSSetNetImage setNetImageWithImageView:self.movieImage imageURL:_model.iconaddress option:DefaultPlaceholder];
    self.titleLabel.text = _model.tvTitle;
    self.subHeadCount.text = _model.subHead;
    self.gradeLabel.text = NSStringFormat(@"评分：%.2f", _model.grade);
    
}


@end
