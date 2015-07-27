//
//  ForumTableViewCell.m
//  FingerIT
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ForumTableViewCell.h"
#import "CommonMacro.h"
@implementation ForumTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}
- (void)addViews {
    self.forumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 30, kScreenHeight / 8)];
    _forumLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_forumLabel];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
