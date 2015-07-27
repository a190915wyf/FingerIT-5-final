//
//  NBCellTwo.m
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NBCellTwo.h"
#import "CommonMacro.h"
#import "UIImageView+WebCache.h"
@implementation NBCellTwo
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}

- (void)addViews {
    self.sortLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 3, kScreenHeight / 25)];
    _sortLabel.font = [UIFont systemFontOfSize:16];

    
    self.itemImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, kScreenHeight / 25, kScreenWidth / 3, kScreenHeight * 4 / 25)];
    
    
    self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3, kScreenHeight / 25,  kScreenWidth * 2 / 3 - 10, kScreenHeight / 10)];
    _itemLabel.font = [UIFont systemFontOfSize:14];
    _itemLabel.numberOfLines = 0;
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3 + 5, kScreenHeight * 4 / 25, kScreenWidth / 5, 40)];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor redColor];
    
    
    self.priceLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 8 / 15 + 5, kScreenHeight * 4 / 25, kScreenWidth / 5, 40)];
    _priceLabelTwo.font = [UIFont systemFontOfSize:15];
    _priceLabelTwo.textColor = [UIColor lightGrayColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(-1, 20, 60, 1)];
    lineView.tag = 2000;
    lineView.backgroundColor = [UIColor redColor];
    [_priceLabelTwo addSubview:lineView];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 3, 0, kScreenWidth * 2 / 3, kScreenHeight / 25)];
    _statusLabel.font = [UIFont systemFontOfSize:14];
    
    self.salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth * 3 / 4, kScreenHeight * 3 / 25, kScreenWidth / 4, 40)];
    _salesLabel.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:_itemImage];
    [self.contentView addSubview:_itemLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_priceLabelTwo];
    [self.contentView addSubview:_statusLabel];
    [self.contentView addSubview:_sortLabel];
    [self.contentView addSubview:_salesLabel];
}






- (void)configureNBCellTwoWithModel:(NBModelTwo *)model {
    [self.itemImage sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    self.itemLabel.text = model.goodsName;
    self.salesLabel.text = [NSString stringWithFormat:@"已售%@件", model.saleNum];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.nowPrice];
    self.priceLabelTwo.text = [NSString stringWithFormat:@"￥%@", model.priceMarket];
    self.sortLabel.text = @" 🔥 爆款推荐";
    self.statusLabel.text = [NSString stringWithFormat:@"还剩 %ld 天 %ld 时 %ld 分 %ld 秒", (long)[model.day integerValue], (long)[model.hour integerValue], (long)[model.minute integerValue], (long)[model.second integerValue]];
}

@end
