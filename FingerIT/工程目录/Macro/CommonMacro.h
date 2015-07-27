


#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define kTopScrollWidth     kScreenWidth
#define kTopScrollHeight    40


#define kContentScrollWidth     kScreenWidth
#define kContentScrollHeight    kScreenHeight - 64 - 40 - 44


#define kMarginLeft_CellView  10
#define kMarginTop_CellView  10
#define kWidth_CellView  (kScreenWidth - 10) / 3 - 20
#define kHeight_CellView  70


#define kMarginLeft_titleLabel  kWidth_CellView + 15
#define kMarginTop_titleLabel  10
#define kWidth_titleLabel  (kScreenWidth - 10)  * 2 / 3
#define kHeight_titleLabel  kHeight_CellView * 2 / 3

#define kMarginLeft_pubDateLabel kMarginLeft_titleLabel
#define kMarginTop_pubDateLabel kHeight_CellView
#define kWidth_pubDateLabel 100
#define kHeight_pubDateLabel 20

#define kMarginLeft_cmtCountLabel   kScreenWidth - kWidth_cmtCountLabel
#define kMarginTop_cmtCountLabel kHeight_CellView
#define kWidth_cmtCountLabel 70
#define kHeight_cmtCountLabel kHeight_pubDateLabel


#define kHeight_tableView kScreenHeight / 3








//资讯
#define kInformationUrl @"http://mrobot.pconline.com.cn/v2/cms/channels/%@?pageNo=%ld&pageSize=20"
//论坛--- 论坛广场
#define kForumSquareUrl @"http://mrobot.pconline.com.cn/v3/itbbs/newForums/%@?&pageNo=%ld&pageSize=20&orderby=replyat"
//论坛 -- 论坛列表
#define kForumListUrl   @"http://itbbs.pconline.com.cn/mobile/topics.ajax?type=hot_week&singleForum=false&noForums=&ie=utf-8&count=100&showImage=true&noForums=762423,2312647&forums=%@"
//论坛 -- 每日精选
#define kpickedUrl @"http://itbbs.pconline.com.cn/mobile/topics.ajax?type=hot_day&forums=8,2,240024,41,240022&count=1&singleForum=false&showImage=false&ie=utf-8&noForums=762423,2312647"
//论坛 -- 每日精选
#define kFeaturedUrl @"http://mrobot.pconline.com.cn/v2/cms/channels/%@?pageNo=%ld&pageSize=20"



