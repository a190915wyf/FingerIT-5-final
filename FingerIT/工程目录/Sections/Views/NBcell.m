//
//  NBcell.m
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//
#define kWidthSalesLabel (kScreenWidth - 30) / 4
#import "NBcell.h"
#import "CommonMacro.h"
#import "UIImageView+WebCache.h"

@implementation NBcell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    //创建itemImage
    self.itemImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 30) / 2, (kScreenWidth - 30) / 3)];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, (kScreenWidth - 30) / 6, 20)];
    _statusLabel.textColor = [UIColor whiteColor];
    _statusLabel.font = [UIFont systemFontOfSize:13];
    _statusLabel.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    
    [self.itemImage addSubview:_statusLabel];
    
    self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenWidth - 30) / 3 + 10, (kScreenWidth - 30) / 2, (kScreenWidth - 30) / 8)];
    _itemLabel.font = [UIFont systemFontOfSize:15];
    _itemLabel.numberOfLines = 0;
    self.salesLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 30) / 2 - kWidthSalesLabel, (kScreenWidth - 30) / 2, kWidthSalesLabel, (kScreenWidth - 30) / 24)];
    _salesLabel.font = [UIFont systemFontOfSize:13];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (kScreenWidth - 30) / 3 + 10 + (kScreenWidth - 30) * 5 / 24, (kScreenWidth - 30) / 4, (kScreenWidth - 30) / 18)];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:16];
    
    self.priceLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 30) / 4, (kScreenWidth - 30) / 3 + 10 + (kScreenWidth - 30) * 5 / 24, (kScreenWidth - 30) / 4, (kScreenWidth - 30) / 18)];
    _priceLabelTwo.font = [UIFont systemFontOfSize:16];
    _priceLabelTwo.textColor = [UIColor lightGrayColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-1, (kScreenWidth - 30) / 36 + 1, 60, 1)];
    lineView.tag = 1000;
    lineView.backgroundColor = [UIColor redColor];
    [_priceLabelTwo addSubview:lineView];
    
    
    [self.contentView addSubview:_itemImage];
    [self.contentView addSubview:_itemLabel];
    [self.contentView addSubview:_salesLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_priceLabelTwo];



}
- (void)configureNBCellWithModel:(NBModel *)model {
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    self.statusLabel.text = model.status;
    self.itemLabel.text = model.goodsName;
    self.salesLabel.text = [NSString stringWithFormat:@"已售%@件", model.saleNum];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.nowPrice];
    self.priceLabelTwo.text = [NSString stringWithFormat:@"￥%@", model.priceMarket];
}

@end
