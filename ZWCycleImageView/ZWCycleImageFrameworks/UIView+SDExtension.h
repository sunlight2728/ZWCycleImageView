//
//  UIView+SDExtension.h
//  SDRefreshView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//



#import <UIKit/UIKit.h>

#define SDColorCreater(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]


@interface UIView (SDExtension)

@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;

@property (nonatomic, assign) CGFloat sd_y;
@property (nonatomic, assign) CGFloat sd_x;

@end
