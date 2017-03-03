//
//  JKREditViewController.m
//  JKRAVCameraDemo
//
//  Created by tronsis_ios on 16/9/1.
//  Copyright © 2016年 tronsis_ios. All rights reserved.
//

#import "JKREditViewController.h"
#import "JKRVideoEditView.h"

@interface JKREditViewController ()

@property (nonatomic, strong) JKRVideoEditView *editView;

@end

@implementation JKREditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _editView = [[JKRVideoEditView alloc] initWithFrame:self.view.bounds video:_video];
    [self.view addSubview:_editView];
}

- (void)dealloc {
    
}

//file:///Users/liam/Desktop/myGitHub/ZWCycleImageView/ZWCycleImageView/MYControllers/YZWFirstViewController/%E9%99%80%E8%9E%BA%E4%BB%AADemo/GravityUtility/UIImage+image.h: warning: Missing file: /Users/liam/Desktop/myGitHub/ZWCycleImageView/ZWCycleImageView/MYControllers/YZWFirstViewController/陀螺仪Demo/GravityUtility/UIImage+image.h is missing from working copy


@end
