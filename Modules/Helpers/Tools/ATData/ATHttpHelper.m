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



@end
