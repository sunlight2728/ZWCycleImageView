//
//  ZWAFNetworking.h
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HttpSuccessBlock)(NSDictionary *JSON);
typedef void (^HttpFailureBlock)(NSString *error);
typedef void (^loginSucceseBlock)(dispatch_block_t loginBlock);

@interface ZWAFNetworking : NSObject




+ (void) CheDaoNoViewAFNRequestWithFirstUrl:(NSString *)firstUrl withSecondUrl:(NSString *)secondUrl withDic:(NSDictionary *)userDictionary success:(void(^)(NSDictionary *success))success failure:(void(^)(NSString *error))failure;


//停止请求
+ (void)stopHttpRequest;



@end
