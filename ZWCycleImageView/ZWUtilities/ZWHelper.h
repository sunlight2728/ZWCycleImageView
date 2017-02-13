//
//  ZWHelper.h
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWHelper : NSObject


+ (id) shareSharedZWHelper ;

+ (void)cancelSharedZWHelperAct;


+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;

+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key;


-(NSString *)ZWMD5WithString:(NSString *)string;


@end

///Users/liam/Desktop/myGitHub/ZWCycleImageView/ZWCycleImageView/ZWUtilities/countly-sdk-ios-master/Countly_OpenUDID.m:295:17: 'setPersistent:' is deprecated: first deprecated in iOS 10.0 - Do not set persistence on pasteboards. This property is set automatically.
