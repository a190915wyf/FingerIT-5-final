//
//  SecondTableViewCell.h
//  FingerIT
//
//  Created by lanou3g on 15/7/8.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InformationCellModel.h"
@interface SecondTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *cellView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pubDateLabel;
@property (nonatomic, strong) UILabel *cmtCountLabel;
//@property (nonatomic, strong) UIPanGestureRecognizer *pan;
- (void)configureCellWithInformationCellModel:(InformationCellModel *)model;

@end
