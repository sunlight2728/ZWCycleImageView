//
//  ZWRootViewController.h
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ZWRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property(strong ,nonatomic) UITableView *zwTableView;
@property(strong ,nonatomic) NSArray *zwDataArray;

-(void)initZWTableView;


@end
