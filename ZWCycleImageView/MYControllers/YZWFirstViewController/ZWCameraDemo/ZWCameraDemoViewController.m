//
//  ZWCameraDemoViewController.m
//  ZWCycleImageView
//
//  Created by liam on 2017/2/17.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import "ZWCameraDemoViewController.h"
#import "JKRCameraView.h"

@interface ZWCameraDemoViewController ()

@property (nonatomic, strong) JKRCameraView *cameraView;

@end

@implementation ZWCameraDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITextView *textView;
    [textView.layoutManager boundingRectForGlyphRange:NSMakeRange(0, 1) inTextContainer:textView.textContainer];
    
    _cameraView = [[JKRCameraView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_cameraView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
