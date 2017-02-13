//
//  ZWAFNetworking.m
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import "ZWAFNetworking.h"
#import "AFHTTPSessionManager.h"

@implementation ZWAFNetworking

#define __USE_weakSelf__ __weak typeof(self) weakSelf = self
NSString * const baseUrl = @"www.baidu.com";

AFHTTPSessionManager *manager;


+ (void)stopHttpRequest
{
//    [LoadingViewHD dismiss];
//    [ProgressHUD dismiss];
//    [HttpTool stopHttpRequest];
}

#pragma mark
+ (void) CheDaoNoViewAFNRequestWithFirstUrl:(NSString *)firstUrl withSecondUrl:(NSString *)secondUrl withDic:(NSDictionary *)userDictionary success:(void(^)(NSDictionary *success))success failure:(void(^)(NSString *error))failure
{
    __USE_weakSelf__;
    NSMutableDictionary *tmpDict =[NSMutableDictionary dictionaryWithDictionary:userDictionary];
    [weakSelf requestWithUrlPath:[firstUrl stringByAppendingString:secondUrl] params:tmpDict success:^(id responseObject)
     {
         NSDictionary *dic = responseObject;
         NSLog(@"%@",dic);
         
     }failure:^(NSString *errorMsg){
         failure(errorMsg);
         
     }POST_FLG:NO];
}

+ (void)requestWithUrlPath:(NSString *)path params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure POST_FLG:(BOOL)method
{
    [manager POST:path parameters:params
         progress:^(NSProgress * _Nonnull uploadProgress) {
             // 这里可以获取到目前数据请求的进度
             NSLog(@"%f",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
           
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             // 请求成功
             if(responseObject){
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 NSLog(@"请求成功 dict = %@",dict);
             } else {
                  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 NSLog(@"请求成功，返回失败 dict = %@",dict);
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"Http_Request_Failed" object:dict userInfo:nil];
             }
             
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"请求成功 %@",error);
             NSString *string = [NSString stringWithFormat:@"%@",error];
             [[NSNotificationCenter defaultCenter] postNotificationName:@"Http_Request_Failed" object:string userInfo:nil];
         }];
}

@end







//@interface AFAppDotNetAPIClient : AFHTTPSessionManager
//
//@end
//
//@implementation AFAppDotNetAPIClient(ZWAFNetworking)
//
//+ (instancetype)sharedClient {
//    
//    static AFAppDotNetAPIClient *_sharedClient = nil;
//    
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        
//        NSString *appVerson =[NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
//        
//        NSString *additionaHeader =[NSString stringWithFormat:@"fujinshenghuo/%@ CFNetwork/672.1.15 Darwin/14.0.0",appVerson];
//        
//        [config setHTTPAdditionalHeaders:@{@"User-Agent":additionaHeader}];
//        
//        //设置缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
//        NSURLCache *cache = [[NSURLCache alloc]
//                             initWithMemoryCapacity:10 * 1024 * 1024
//                             diskCapacity:50 * 1024 * 1024
//                             diskPath:nil];
//        
//        [config setURLCache:cache];
//        
//        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:config];
//        
//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//        
//        [_sharedClient setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition (NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential){
//            
//            return NSURLSessionAuthChallengePerformDefaultHandling;
//            
//        }];
//    });
//    
//    return _sharedClient;
//}
//
//- (id)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
//{
//    self = [super initWithBaseURL:url sessionConfiguration:configuration];
//    
//    if (self)
//    {
//        [self setUrlCertifier];
//        
//        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain",@"application/rtf",nil]];
//    }
//    return self;
//}
//
//- (void)setUrlCertifier
//{
//    self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    
//    [self setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition (NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential * __autoreleasing *credential){
//        
//        return NSURLSessionAuthChallengePerformDefaultHandling;
//        
//    }];
//    
//}
//
//+ (void)stopHttpRequest
//{
//
//}
//@end
