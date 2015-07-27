//
//  HappyBuyHeaderReusableView.m
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HappyBuyHeaderReusableView.h"

@implementation HappyBuyHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}
- (void)addViews {
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:_titleLabel];
}


 



@end
