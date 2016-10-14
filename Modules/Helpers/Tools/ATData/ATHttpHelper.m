//
//  ATHttpHelper.m
//  APP_TEST
//
//  Created by 认默 on 2016/10/14.
//  Copyright © 2016年 默认. All rights reserved.
//

#import "ATHttpHelper.h"
#import "AFNetworking.h"

@implementation ATHttpHelper

+(AFHTTPSessionManager *)getRequestManager
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //请求超时设置
    manager.requestSerializer.timeoutInterval=30.f;
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    //证书
//    manager.securityPolicy.allowInvalidCertificates=YES;
    return manager;
}

/**
 网络状态
 */
+(BOOL)netWorkReachability
{
    __block bool netState=NO;
    
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    
    NSOperationQueue *operationQueue=manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝网络3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState=YES;
                NSLog(@"WiFi");
                break;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    //开启监听
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}

/**
 *  GET请求
 */
+(void)getRequest:(NSString *)url
           params:(NSDictionary *)params
          success:(requestSucessBlock)successHandler
          failure:(requestFailureBlock)failureHandler
{
    if (![self netWorkReachability]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager=[self getRequestManager];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"-------GET请求进度-------%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"--------GET请求失败--------%@",error);
        failureHandler(error);
    }];
}

/**
 *  POST请求
 */
+(void)postRequst:(NSString *)url
           params:(NSDictionary *)params
          success:(requestSucessBlock)successHandler
          failure:(requestFailureBlock)failureHandler
{
    if (![self netWorkReachability]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager=[self getRequestManager];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---------POST上传请求进度--------%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---------POST请求失败---------%@",error);
        failureHandler(error);
    }];
}

/**
 *  PUT请求
 */
+(void)putRequst:(NSString *)url
          params:(NSDictionary *)params
         success:(requestSucessBlock)successHandler
         failure:(requestFailureBlock)failureHandler
{
    if (![self netWorkReachability]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager=[self getRequestManager];
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------PUT请求失败-------%@",error);
        failureHandler(error);
    }];
}

/**
 *  DELETE请求
 */
+(void)deleteRequst:(NSString *)url
             params:(NSDictionary *)params
            success:(requestSucessBlock)successHandler
            failure:(requestFailureBlock)failureHandler
{
    if (![self getRequestManager]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager=[self getRequestManager];
    [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"------DELETE请求失败-------%@",error);
        failureHandler(error);
    }];
}

/**
 *  下载文件，进度
 */
+(void)downloadFileRequest:(NSString *)url
                    params:(NSDictionary *)params
                fileConfig:(ATFileConfig *)fileConfig
              fileProgress:(progressBlock)progressHandler
                  complete:(reponseBlock)completionHandler
{
    if (![self getRequestManager]) {
        progressHandler(0,0,0);
        completionHandler(nil,nil);
        return;
    }
    
    NSURLSessionConfiguration *sessionConfiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager=[[AFURLSessionManager alloc] initWithSessionConfiguration:sessionConfiguration];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSProgress *kProgress=nil;
    
    NSURLSessionDownloadTask *downloadTask =[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
//???:进度
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentUrl=[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentUrl URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            NSLog(@"----------文件下载失败-------%@",error);
        }
        completionHandler(response,error);
    }];
    
    //注意：在下载任务完成后，下载的文件位于tmp目录下，由代码块中的location指定，
    //我们必须要在completion handler中将文件放到持久化的目录下保存。
    
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDownloadTask * _Nonnull downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        progressHandler(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];
    //开启任务
    [downloadTask resume];
}

/**
 *  上传文件
 */
+(void)uploadFileRequest:(NSString *)url
                  params:(NSDictionary *)params
              fileConfig:(ATFileConfig *)fileConfig
                 success:(requestSucessBlock)successHandler
                 failure:(requestFailureBlock)failureHandler
{
    if (![self getRequestManager]) {
        successHandler(nil);
        failureHandler(nil);
        return;
    }
    
    AFHTTPSessionManager *manager=[self getRequestManager];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileConfig.fileData name:fileConfig.name fileName:fileConfig.fileName mimeType:fileConfig.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successHandler(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"----------上传文件失败-------%@",error);
        failureHandler(error);
    }];
}


@end
