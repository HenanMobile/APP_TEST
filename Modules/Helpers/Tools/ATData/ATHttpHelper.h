//
//  ATHttpHelper.h
//  APP_TEST
//网络请求
//  Created by 认默 on 2016/10/14.
//  Copyright © 2016年 默认. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ATFileConfig;

///请求成功
typedef void (^requestSucessBlock)(id responseObj);

///请求失败
typedef void (^requestFailureBlock)(NSError *error);

///请求响应
typedef void (^reponseBlock)(id responseObj,NSError *error);

///监听响应进度
typedef void (^progressBlock)(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedTowrite);


///网络数据请求类
@interface ATHttpHelper : NSObject

///网络状态
+(BOOL)netWorkReachability;

///GET请求
+(void)getRequest:(NSString *)url
           params:(NSDictionary *)params
          success:(requestSucessBlock)successHandler
          failure:(requestFailureBlock)failureHandler;

///POST请求
+(void)postRequst:(NSString *)url
           params:(NSDictionary *)params
          success:(requestSucessBlock)successHandler
          failure:(requestFailureBlock)failureHandler;

///PUT请求
+(void)putRequst:(NSString *)url
           params:(NSDictionary *)params
          success:(requestSucessBlock)successHandler
          failure:(requestFailureBlock)failureHandler;

///DELETE请求
+(void)deleteRequst:(NSString *)url
           params:(NSDictionary *)params
          success:(requestSucessBlock)successHandler
          failure:(requestFailureBlock)failureHandler;

///文件上传
+(void)uploadFileRequest:(NSString *)url
                  params:(NSDictionary *)params
              fileConfig:(ATFileConfig *)fileConfig
            success:(requestSucessBlock)successHandler
                failure:(requestFailureBlock)failureHandler;

///文件上传,进度
+(void)uploadFileRequest:(NSString *)url
                  params:(NSDictionary *)params
              fileConfig:(ATFileConfig *)fileConfig
            fileProgress:(progressBlock)progressHandler
                complete:(reponseBlock)completionHandler;

///文件下载，进度
+(void)downloadFileRequest:(NSString *)url
                    params:(NSDictionary *)params
                fileConfig:(ATFileConfig *)fileConfig
              fileProgress:(progressBlock)progressHandler
                  complete:(reponseBlock)completionHandler;

@end

///上传文件数据模型
@interface ATFileConfig : NSObject

///文件数据
@property (nonatomic,strong) NSData *fileData;

///服务器接受参数名
@property (nonatomic,copy) NSString *name;

///文件名
@property (nonatomic,copy) NSString *fileName;

///文件类型
@property (nonatomic,copy) NSString *mimeType;

+(instancetype)fileConfigWithFileData:(NSData *)fileData
                                 name:(NSString *)name
                             fileName:(NSString *)fileName
                             mimiType:(NSString *)mimeType;

-(instancetype)initWithFileData:(NSData *)fileData
                                 name:(NSString *)name
                             fileName:(NSString *)fileName
                             mimiType:(NSString *)mimeType;

@end








