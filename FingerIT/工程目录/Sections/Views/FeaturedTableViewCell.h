//
//  FeaturedTableViewCell.h
//  FingerIT
//
//  Created by lanou3g on 15/7/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumListModel.h"

@interface FeaturedTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *forumNameLabel;
@property (nonatomic, strong) UILabel *floorLabel;
@property (nonatomic, strong) UILabel *timeLabel;


- (void)configureCellWithModel:(ForumListModel *)model;
@end
