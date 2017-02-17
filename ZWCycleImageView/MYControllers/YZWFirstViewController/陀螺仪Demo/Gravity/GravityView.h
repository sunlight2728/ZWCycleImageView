//
//  GravityView.h
//  GyroscopeTest
//
//  Created by Seven-Augus on 16/8/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GravityView : UIView

/**
 *  @param 显示的图片
 */
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong, readonly) UIImageView *myImageView;

/**
 *  @param 开始重力感应
 */
- (void)startAnimate;

/**
 *  @param 停止重力感应
 */
- (void)stopAnimate;

@end
