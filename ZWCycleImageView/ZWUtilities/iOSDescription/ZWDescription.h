//
//  ZWDescription.h
//  ZWCycleImageView
//
//  Created by liam on 2017/2/17.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//


#import <Foundation/Foundation.h>


typedef void (^HttpSuccessBlock)(id JSON);
typedef void (^HttpFailureBlock)(NSString *error);
typedef void (^loginSucceseBlock)(dispatch_block_t zwBlock);



@interface ZWDescription : NSObject

/*
 
 ZWDescription *dd =[[ZWDescription alloc] init];
 __USE_weakSelf__;
 
 dd.backValue  =^(BOOL value,NSDictionary *dict){
    if(value==YES){}else{}}
 
 [ZWDescription SharedZWDescription].backValue=^(BOOL value,NSDictionary *dict){
 if(value==YES){}else{}}

 */

@property (copy, nonatomic) void (^backValue)(BOOL intValue,NSDictionary *zwDict);

+(id)SharedZWDescription ;

-(void)zwCTCellularDataDescription;





@end
