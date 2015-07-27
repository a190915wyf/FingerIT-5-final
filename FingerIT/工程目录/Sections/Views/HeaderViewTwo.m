//
//  HeaderViewTwo.m
//  FingerIT
//
//  Created by lanou3g on 15/7/16.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "HeaderViewTwo.h"
#import "CommonMacro.h"

@implementation HeaderViewTwo
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
    }
    return self;
}
- (void)addViews {
    self.scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight / 4);
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.pagingEnabled = YES;
    [self addSubview:_scroll];
    for (int i = 0; i < 3; i++) {
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + kScreenWidth * i, 0, kScreenWidth, kScreenHeight / 4)];
        headerImageView.userInteractionEnabled = YES;
        headerImageView.tag = 500 + i;
        [self.scroll addSubview:headerImageView];
    }
}
@end
