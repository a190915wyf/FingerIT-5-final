//
//  NBcell.h
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBModel.h"
@interface NBcell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *itemImage;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *salesLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *priceLabelTwo;


- (void)configureNBCellWithModel:(NBModel *)model;

@end
