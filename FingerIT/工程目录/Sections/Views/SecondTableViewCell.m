//
//  SecondTableViewCell.m
//  FingerIT
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "CommonMacro.h"
#import "UIImageView+WebCache.h"
@implementation SecondTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.cellView = [[UIImageView alloc] initWithFrame:CGRectMake(kMarginLeft_CellView, kMarginTop_CellView, kWidth_CellView, kHeight_CellView)];
        [self.contentView addSubview:self.cellView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMarginLeft_titleLabel, kMarginTop_titleLabel, kWidth_titleLabel, kHeight_titleLabel)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.titleLabel];
        
         self.pubDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMarginLeft_pubDateLabel, kMarginTop_pubDateLabel, kWidth_pubDateLabel, kHeight_pubDateLabel)];
        _pubDateLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.pubDateLabel];
        
         self.cmtCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMarginLeft_cmtCountLabel, kMarginTop_cmtCountLabel, kWidth_cmtCountLabel, kHeight_cmtCountLabel)];
        _cmtCountLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.cmtCountLabel];
        
    }

    return  self;
}

- (void)configureCellWithInformationCellModel:(InformationCellModel *)model {
    [self.cellView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.titleLabel.text = model.title;
    self.pubDateLabel.text = model.pubDate;
    self.cmtCountLabel.text = [NSString stringWithFormat:@"%ld评论",  (long)[model.cmtCount integerValue]];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
