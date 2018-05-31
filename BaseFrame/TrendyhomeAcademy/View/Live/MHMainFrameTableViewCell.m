//
//  MHMainFrameTableViewCell.m
//  WeChat
//
//  Created by senba on 2017/10/20.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "MHMainFrameTableViewCell.h"
#import "FSLiveModel.h"

@interface MHMainFrameTableViewCell ()
/// viewModel
@property (nonatomic, readwrite, strong) FSLiveModel *viewModel;

/// avatarView
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
/// nickenameLabel
@property (weak, nonatomic) IBOutlet UILabel *nickenameLabel;
/// locationBtn
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
/// starLevelView
@property (weak, nonatomic) IBOutlet UIImageView *starLevelView;
/// audienceNumsLabel
@property (weak, nonatomic) IBOutlet UILabel *audienceNumsLabel;
/// coverView
@property (weak, nonatomic) IBOutlet UIImageView *coverView;
/// headTipsBtn
@property (weak, nonatomic) IBOutlet UIButton *headTipsBtn;
/// signView
@property (weak, nonatomic) IBOutlet UIImageView *signView;

@end

@implementation MHMainFrameTableViewCell

#pragma mark - Public Method
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MHMainFrameTableViewCell";
    MHMainFrameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [self mh_viewFromXib];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)bindViewModel:(FSLiveModel *)viewModel{
    self.viewModel = viewModel;
    
    [FSSetNetImage setNetImageWithImageView:self.avatarView imageURL:viewModel.smallpic option:DefaultUserHeader];
    self.signView.hidden = !viewModel.isSign;
    
    self.nickenameLabel.text = viewModel.myname;
    self.starLevelView.image = [UIImage imageNamed:viewModel.girlStar];//MHImageNamed(viewModel.girlStar);
    
    [self.locationBtn setTitle:viewModel.gps forState:UIControlStateNormal];
    self.audienceNumsLabel.attributedText = viewModel.allNumAttr;
    
    [self.headTipsBtn setTitle:viewModel.familyName forState:UIControlStateNormal];
    [FSSetNetImage setNetImageWithImageView:self.coverView imageURL:viewModel.smallpic option:DefaultUserHeader];
    
}

#pragma mark - Private Method
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
