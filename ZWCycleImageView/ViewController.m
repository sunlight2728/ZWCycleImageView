//
//  ViewController.m
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import "ViewController.h"
#import "ZWCycleImageView.h"

#define SCREEN_SCALE_SHOW(MM) (MM*SCREEN_WIDTH/320)
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)

@interface ViewController () <ZWCycleImageViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:0.99];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"005.jpg"]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    
    UIScrollView *demoContainerView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    demoContainerView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self.view addSubview:demoContainerView];
    
    self.title = @"轮播Demo";
    
    
    // 情景一：采用本地图片实现
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            @"h7" // 本地图片请填写全名
                            ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"感谢您的支持",
                        @"感谢您的支持，如果下载的过程中出现问题",
                        @"如果代码在使用过程中出现问题",
                        @"您可以到https://github.com/sunlight2728/ZWCycleImageView"
                        ];
    
    CGFloat w = self.view.bounds.size.width;
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 本地加载 --- 创建不带标题的图片轮播器
    ZWCycleImageView *zwCycleImageView = [ZWCycleImageView ZWCycleImageViewWithFrame:CGRectMake(0, 64, w, 180) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    zwCycleImageView.delegate = self;
    zwCycleImageView.pageControlStyle = ZWCycleImageViewPageContolStyleAnimated;
    [demoContainerView addSubview:zwCycleImageView];
    zwCycleImageView.scrollDirection = UICollectionViewScrollDirectionVertical;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    //cycleScrollView.autoScrollTimeInterval = 4.0;
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建带标题的图片轮播器
    ZWCycleImageView *zwCycleImageView2  = [ZWCycleImageView ZWCycleImageViewWithFrame:CGRectMake(0, CGRectGetMaxY(zwCycleImageView.frame)+20, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    zwCycleImageView2.pageControlAliment = ZWCycleImageViewPageContolStyleAnimated;
    zwCycleImageView2.titlesGroup = titles;
    zwCycleImageView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [demoContainerView addSubview:zwCycleImageView2];
    
    //         --- 模拟加载延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        zwCycleImageView2.imageURLStringsGroup = imagesURLStrings;
    });
    
    /*
     block监听点击方式
     
     cycleScrollView2.clickItemOperationBlock = ^(NSInteger index) {
     NSLog(@">>>>>  %ld", (long)index);
     };
     
     */
    
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图3 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建自定义图片的pageControlDot的图片轮播器
    ZWCycleImageView *zwCycleImageView3 = [ZWCycleImageView ZWCycleImageViewWithFrame:CGRectMake(0, CGRectGetMaxY(zwCycleImageView2.frame)+20, w, 180) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    zwCycleImageView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
    zwCycleImageView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
    zwCycleImageView3.imageURLStringsGroup = imagesURLStrings;
    
    [demoContainerView addSubview:zwCycleImageView3];
    
    // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    
    // 网络加载 --- 创建只上下滚动展示文字的轮播器
    // 由于模拟器的渲染问题，如果发现轮播时有一条线不必处理，模拟器放大到100%或者真机调试是不会出现那条线的
    ZWCycleImageView *zwCycleImageView4 = [ZWCycleImageView ZWCycleImageViewWithFrame:CGRectMake(0, CGRectGetMaxY(zwCycleImageView3.frame)+20, w, 40) delegate:self placeholderImage:nil];
    zwCycleImageView4.scrollDirection = UICollectionViewScrollDirectionVertical;
    zwCycleImageView4.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    [titlesArray addObjectsFromArray:titles];
    zwCycleImageView4.titlesGroup = [titlesArray copy];
    
    [demoContainerView addSubview:zwCycleImageView4];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 如果你发现你的CycleScrollview会在viewWillAppear时图片卡在中间位置，你可以调用此方法调整图片位置
    //    [你的CycleScrollview adjustWhenControllerViewWillAppera];
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(ZWCycleImageView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
}


/*
 
 // 滚动到第几张图回调
 - (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
 {
 NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
 }
 
 */


@end
