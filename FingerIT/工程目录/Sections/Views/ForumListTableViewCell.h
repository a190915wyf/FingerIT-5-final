//
//  ForumListTableViewCell.h
//  FingerIT
//
//  Created by lanou3g on 15/7/14.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForumListModel.h"
#import "ForumListModelTwo.h"
@interface ForumListTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *forumListImageView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *forumNameLabel;
@property (nonatomic, strong) UILabel *floorLabel;
@property (nonatomic, strong) UILabel *timeLabel;




- (void)configureCellWithModel:(ForumListModel *)model;
- (void)configureCellWithModelTwo:(ForumListModelTwo *)model;

@end
