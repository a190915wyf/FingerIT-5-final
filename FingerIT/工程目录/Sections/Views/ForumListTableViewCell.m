//
//  ForumListTableViewCell.m
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define kHeight_forumListImageView 140
#define kHeight_titleLabelList 350 * kScreenHeight / 667 / 5

#import "ForumListTableViewCell.h"
#import "CommonMacro.h"
#import "UIImageView+WebCache.h"
@implementation ForumListTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
        self.layer.borderColor=[UIColor lightGrayColor].CGColor;
        self.layer.borderWidth= 0.3;
    
    }
    return self;

}

- (void)addViews {
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, 1)];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 6, 6, 1, kScreenHeight* 350 / 667 - 12)];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(5, kScreenHeight * 350 / 667 - 6, kScreenWidth - 10, 1)];
    lineView3.backgroundColor = [UIColor lightGrayColor];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(5, 6, 1, kScreenHeight * 350 / 667  - 12)];
    lineView4.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView1];
    [self.contentView addSubview:lineView2];
    [self.contentView addSubview:lineView3];
    [self.contentView addSubview:lineView4];




    
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 20, kHeight_titleLabelList)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    
    self.forumListImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, kHeight_titleLabelList, kScreenWidth - 20, kHeight_forumListImageView)];
    [self.contentView addSubview:_forumListImageView];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kHeight_titleLabelList + kHeight_forumListImageView, kScreenWidth - 20, kHeight_titleLabelList - 10)];
    _messageLabel.font = [UIFont systemFontOfSize:14];
    _messageLabel.numberOfLines = 0;
    [self.contentView addSubview:_messageLabel];
    
    self.forumNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 350 * kScreenHeight / 667 - 22, kScreenWidth / 3 , 20)];
    _forumNameLabel.font = [UIFont systemFontOfSize:13];
    _forumNameLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:_forumNameLabel];
    
    self.floorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3 + 10, 350 * kScreenHeight / 667 - 22, kScreenWidth / 3 + 10 , 20)];
    _floorLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_floorLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 2 / 3, 350 * kScreenHeight / 667 - 22, kScreenWidth / 3 , 20)];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_timeLabel];
}



- (void)configureCellWithModel:(ForumListModel *)model {
    self.titleLabel.text = model.title;
    [self.forumListImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.messageLabel.text = model.message;
    self.forumNameLabel.text = model.forumName;
    self.floorLabel.text = [NSString stringWithFormat:@"%ld阅/%ld楼", (long)[model.viewCount integerValue], (long)[model.replyCount integerValue]];
    self.timeLabel.text = [model.createAt substringToIndex:10];
}

- (void)configureCellWithModelTwo:(ForumListModelTwo *)model {
    self.titleLabel.text = model.title;
    [self.forumListImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.messageLabel.text = model.message;
    self.forumNameLabel.text = model.name;
    self.floorLabel.text = [NSString stringWithFormat:@"%ld阅/%ld楼", (long)[model.view integerValue], (long)[model.replyCount integerValue]];
    //时间戳转换成时间
    NSString *timeString = [NSString stringWithFormat:@"%f", [model.createAt floatValue]];
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
