//
//  NBCellTwo.h
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBModelTwo.h"
@interface NBCellTwo : UICollectionViewCell
@property (nonatomic, strong) UILabel *sortLabel;
@property (nonatomic, strong) UIImageView *itemImage;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *priceLabelTwo;
@property (nonatomic, strong) UILabel *salesLabel;


- (void)configureNBCellTwoWithModel:(NBModelTwo *)model;


@end
