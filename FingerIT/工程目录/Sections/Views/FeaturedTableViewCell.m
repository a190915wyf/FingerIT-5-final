//
//  FeaturedTableViewCell.m
//  FingerIT
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FeaturedTableViewCell.h"
#import "CommonMacro.h"

@implementation FeaturedTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}
- (void)addViews {
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 6, 6, 1, kScreenHeight / 6 - 12)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(5, kScreenHeight / 6 - 6, kScreenWidth - 10, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(5, 6, 1, kScreenHeight / 6  - 12)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView1];
    [self.contentView addSubview:lineView2];
    [self.contentView addSubview:lineView3];
    [self.contentView addSubview:lineView4];
    
       
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, kScreenWidth - 20, kScreenHeight / 24)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    
    self.forumNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreenHeight / 11, kScreenWidth / 3 , 30)];
    _forumNameLabel.font = [UIFont systemFontOfSize:13];
    _forumNameLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_forumNameLabel];
    
    self.floorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3 + 10, kScreenHeight / 11, kScreenWidth / 3 + 10 , 30)];
    _floorLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_floorLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 2 / 3, kScreenHeight / 11, kScreenWidth / 3 , 30)];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_timeLabel];

}

- (void)configureCellWithModel:(ForumListModel *)model {
    self.titleLabel.text = model.title;
    self.forumNameLabel.text = model.forumName;
    self.floorLabel.text = [NSString stringWithFormat:@"%ld阅/%ld楼", (long)[model.viewCount integerValue],  (long)[model.replyCount integerValue]];
    self.timeLabel.text = [model.createAt substringToIndex:10];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
