//
//  ForumSquareTableViewCell.m
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define kHeight_forumSquareImageView kScreenHeight * 2 / 9 - 5 
#define kHeight_titleLabelSquare kScreenHeight / 15

#import "ForumSquareTableViewCell.h"
#import "CommonMacro.h"
#import "UIImageView+WebCache.h"
@implementation ForumSquareTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.layer.borderWidth= 0.3;

    }
    
    return self;
}
- (void) addViews {
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 6, 6, 1, kScreenHeight / 3 - 12)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(5, kScreenHeight / 3 - 6, kScreenWidth - 10, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(5, 6, 1, kScreenHeight / 3  - 12)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView1];
    [self.contentView addSubview:lineView2];
    [self.contentView addSubview:lineView3];
    [self.contentView addSubview:lineView4];

    
    
    
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, kScreenWidth - 40, kHeight_titleLabelSquare)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    self.floorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth  / 2,  kScreenHeight / 3 - 30, kScreenWidth / 2, 25)];
    _floorLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_floorLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kScreenHeight / 3 - 30, kScreenWidth / 4, 25)];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_timeLabel];
    
    self.forumSquareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, kHeight_titleLabelSquare + 2, kScreenWidth - 40, kHeight_forumSquareImageView)];
    [self.contentView addSubview:_forumSquareImageView];
}

- (void) configureCellWithModel:(ForumSquareModel *)model{
    self.titleLabel.text = model.title;
    self.floorLabel.text = [NSString stringWithFormat:@"%ld阅/%ld楼", (long)[model.view integerValue], (long)[model.replyCount integerValue]];
    [self.forumSquareImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    //时间戳转换成时间
    NSString *timeString = [NSString stringWithFormat:@"%f", [model.createAt doubleValue]];
    NSTimeInterval interval = [[timeString substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    self.timeLabel.text = [[NSString stringWithFormat:@"%@", date] substringToIndex:10];

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
