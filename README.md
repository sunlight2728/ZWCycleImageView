# ZWCycleImageView
 ZWCycleImageView 是一个广告轮播图，多张图片可以轮播，也可以实现其他样式，比如文字上下轮播
 
[ZWCycleImageView](https://github.com/sunlight2728/ZWCycleImageView)
===================================================

ZWCycleImageView 使用的是 SDWebImage 请自行下载，或者使用pod.

ZWCycleImageView 是一个view，可以添加到任意界面上
ZWCycleImageView 使用delegate返回数据.

/** 点击图片回调 */
- (void)ZWCycleImageView:(ZWCycleImageView *)ZWCycleImageView didSelectItemAtIndex:(NSInteger)index;

/** 图片滚动回调 */
- (void)ZWCycleImageView:(ZWCycleImageView *)ZWCycleImageView didScrollToIndex:(NSInteger)index;


