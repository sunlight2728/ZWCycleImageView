//
//  YZWFirstViewController.m
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import "YZWFirstViewController.h"


@interface YZWFirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong ,nonatomic) NSArray *dataArr;
@property(strong ,nonatomic) NSArray *nameArr;

@end

@implementation YZWFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  
    
    self.dataArr = [[NSArray alloc] initWithObjects:@"ZWCycleImageDEMOViewController", nil];
    
    self.nameArr = [[NSArray alloc] initWithObjects:@"滚动视图,轮播图，广告业，轮播字", nil];
    
    
    [self showMyTable];
}



-(void)showMyTable
{
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    table.delegate = self ;
    table.dataSource = self ;
    table.tableFooterView = [UIView new];
    [self.view addSubview:table];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier=@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.nameArr[indexPath.row]];
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexPath = %ld",(long)indexPath.row);
    
    Class class = NSClassFromString([self.dataArr objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:[[class alloc] init] animated:YES];
}




@end
